import Foundation

enum AssistantErrorMapper {
    static func map(_ error: Error) -> String {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "It looks like you're offline. Check your internet connection 🔌"
            case .timedOut:
                return "Connection timed out. Please try again in a moment ⏱️"
            default:
                return "Connection error. Please try again 🛠️"
            }
        } else if error is DecodingError {
            return "The assistant encountered an error processing the reply. Please try again ⚠️"
        } else {
            return "An unexpected error occurred. Please try again ⚠️"
        }
    }
}
