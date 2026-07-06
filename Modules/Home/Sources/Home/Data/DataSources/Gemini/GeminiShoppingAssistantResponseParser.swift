import Foundation

struct GeminiShoppingAssistantResponseParser {
    
    init() {}
    
    func parse(response: GeminiDirectResponse) throws -> AssistantReply {
        guard let rawJSONText = response.candidates.first?.content.parts.first?.text else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [], debugDescription: "No reply text from Gemini candidate"))
        }
        
        let cleanedJSONText = rawJSONText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let jsonData = cleanedJSONText.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Corrupted string encoding"))
        }
        
        return try JSONDecoder().decode(AssistantReply.self, from: jsonData)
    }
}
