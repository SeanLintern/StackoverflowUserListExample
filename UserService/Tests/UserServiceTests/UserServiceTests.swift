import Foundation
import Testing
import Networking

@testable import UserService

struct UserServiceTests {

    private static let testUsers: [StackOverflowUser] = [
        StackOverflowUser(id: 1, name: "User 1", reputation: 999, profileImage: .applicationDirectory),
        StackOverflowUser(id: 2, name: "User 2", reputation: 666, profileImage: .applicationDirectory),
        StackOverflowUser(id: 3, name: "User 3", reputation: 333, profileImage: .applicationDirectory),
    ]

    @Test("Test users are returned")
    func testUsersAreReturnedSuccessfully() async throws {
        let list = StackOverflowUserList(items: Self.testUsers)
        let data = try JSONEncoder().encode(list)
        let mock = MockClient(data: data)
        let sut = StackOverflowUserService(client: mock)
        let users = try await sut.topTwentyStackOverflowUsersByReputation()
        #expect(users == Self.testUsers)
    }
}
