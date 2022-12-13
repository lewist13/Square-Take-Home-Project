import Foundation

/// Enum of various throwable error messages 
enum ErrorMessage: String, Error {
    case invalidURL = "The URL is invalid."
    case invalidResponse = "The server returned an invalid response."
    case invalidData = "Invalid data returned from server"
    case decodingError = "Error decoding data"
    case parseError = "Cannot parse data"
    case imageFound = "Image found in cache"
    case imageNotFound = "Image not found in cache, adding to cache"
    case employeeNotFetched = "Error fetching employee data"
}
