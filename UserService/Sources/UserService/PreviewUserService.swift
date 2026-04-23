import Foundation
import Networking

public struct PreviewUserService: UserService {
    private let shouldFailure: Bool

    public init(shouldFailure: Bool = false) {
        self.shouldFailure = shouldFailure
    }

    public func topTwentyStackOverflowUsersByReputation() async throws -> [StackOverflowUser] {
        guard !shouldFailure else { return [] }

        return [
            StackOverflowUser(id: 1, name: "Gabe Newell", reputation: 999, profileImage: .applicationDirectory),
            StackOverflowUser(id: 2, name: "Tim Apple", reputation: 666, profileImage: .applicationDirectory),
            StackOverflowUser(id: 3, name: "Bill Gates", reputation: 333, profileImage: .applicationDirectory),
        ]
    }
}
