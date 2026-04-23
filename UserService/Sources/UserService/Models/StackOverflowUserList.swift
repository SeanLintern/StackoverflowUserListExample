import Foundation

struct StackOverflowUserList: Codable {
    let items: [StackOverflowUser]

    init(items: [StackOverflowUser]) {
        self.items = items
    }
}
