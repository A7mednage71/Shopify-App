import Foundation

protocol GeminiClientProtocol: Sendable {
    func generateContent(body: GeminiDirectRequestBody) async throws -> GeminiDirectResponse
}

struct GeminiClient: GeminiClientProtocol {
    private var geminiApiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String,
              !key.isEmpty else {
            return ""
        }
        return key
    }
    
    func generateContent(body: GeminiDirectRequestBody) async throws -> GeminiDirectResponse {
        let key = geminiApiKey
        guard !key.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=\(key)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("--- Gemini API Network Error (HTTP \(httpResponse.statusCode)) ---")
            if let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print("Error Details: \(errorJson)")
            } else if let rawString = String(data: data, encoding: .utf8) {
                print("Raw Error Response: \(rawString)")
            }
            print("-----------------------------------------------------")
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(GeminiDirectResponse.self, from: data)
    }
}
