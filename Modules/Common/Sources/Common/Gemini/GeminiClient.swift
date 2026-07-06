import Foundation

public protocol GeminiClientProtocol: Sendable {
    func generateContent<Request: Encodable & Sendable, Response: Decodable & Sendable>(
        body: Request,
        responseType: Response.Type
    ) async throws -> Response
}

public struct GeminiClient: GeminiClientProtocol {
    private let apiKeyProvider: @Sendable () -> String?
    private let urlSession: URLSession

    public init(
        apiKeyProvider: @escaping @Sendable () -> String? = {
            Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String
        },
        urlSession: URLSession = .shared
    ) {
        self.apiKeyProvider = apiKeyProvider
        self.urlSession = urlSession
    }

    public func generateContent<Request: Encodable & Sendable, Response: Decodable & Sendable>(
        body: Request,
        responseType: Response.Type
    ) async throws -> Response {
        guard let key = apiKeyProvider()?.trimmingCharacters(in: .whitespacesAndNewlines),
              !key.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }

        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=\(key)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await urlSession.data(for: request)

        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            logErrorResponse(statusCode: httpResponse.statusCode, data: data)
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(Response.self, from: data)
    }

    private func logErrorResponse(statusCode: Int, data: Data) {
        print("Gemini API error response. HTTP status: \(statusCode)")

        guard !data.isEmpty else {
            print("Gemini API error body: <empty>")
            return
        }

        if let json = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .sortedKeys]),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            print("Gemini API error body:\n\(prettyString)")
            return
        }

        if let rawString = String(data: data, encoding: .utf8) {
            print("Gemini API error body:\n\(rawString)")
        } else {
            print("Gemini API error body: <\(data.count) bytes, non-UTF8>")
        }
    }
}
