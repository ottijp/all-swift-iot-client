enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

enum APIError: Error {
    case network
    case invalidResponse
    case other
}
