import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case serverError(String)
    case decodingError
    case validationError(String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response."
        case .serverError(let message):
            return message
        case .decodingError:
            return "Could not decode the server response."
        case .validationError(let message):
            return message
        }
    }
}
