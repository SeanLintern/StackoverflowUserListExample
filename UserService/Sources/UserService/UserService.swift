public protocol UserService {
    func topTwentyStackOverflowUsersByReputation() async throws -> [StackOverflowUser]
}

public enum UserServiceError: Error {
    case malformedRequest
}
