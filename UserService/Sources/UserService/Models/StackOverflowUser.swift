import Foundation

public struct StackOverflowUser: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case reputation
        case profileImage = "profile_image"
    }

    let id: Int
    let name: String
    let reputation: Int
    let profileImage: URL

    init(id: Int, name: String, reputation: Int, profileImage: URL) {
        self.id = id
        self.name = name
        self.reputation = reputation
        self.profileImage = profileImage
    }
}
