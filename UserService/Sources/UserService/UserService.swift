protocol UserService {
    func topTwentyStackOverflowUsersByReputation() async throws -> [StackOverflowUser]
}

enum UserServiceError: Error {
    case malformedRequest
}
