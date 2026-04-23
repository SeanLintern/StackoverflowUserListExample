import Foundation
import Networking

public struct PreviewUserService: UserService {
    public init() {}

    public func topTwentyStackOverflowUsersByReputation() async throws -> [StackOverflowUser] {
        [
            StackOverflowUser(id: 1, name: "Gabe Newell", reputation: 999, profileImage: .applicationDirectory),
            StackOverflowUser(id: 2, name: "Tim Apple", reputation: 666, profileImage: .applicationDirectory),
            StackOverflowUser(id: 3, name: "Bill Gates", reputation: 333, profileImage: .applicationDirectory),
        ]
    }
}
