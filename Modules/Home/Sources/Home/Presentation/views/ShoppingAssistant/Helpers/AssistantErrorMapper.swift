import Foundation
import Common

enum AssistantErrorMapper {
    static func map(_ error: Error) -> String {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return L10n.Home.assistantOfflineError
            case .timedOut:
                return L10n.Home.assistantTimeoutError
            default:
                return L10n.Home.assistantConnectionError
            }
        } else if error is DecodingError {
            return L10n.Home.assistantProcessingError
        } else {
            return L10n.Home.assistantUnexpectedError
        }
    }
}
