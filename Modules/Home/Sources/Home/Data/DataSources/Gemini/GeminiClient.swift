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
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(GeminiDirectResponse.self, from: data)
    }
}
