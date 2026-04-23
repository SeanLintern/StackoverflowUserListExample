import Foundation

public class LocalFollowService: FollowService {
    private static let storageKey = "FollowingIDs"
    private var following: Set<Int> = []

    private var ephemeral: Bool
    private var storage: UserDefaults

    /// Service for following users
    /// - Parameter ephemeral: Wether the sessions data should only be kept in memory
    public init(ephemeral: Bool = false, storage: UserDefaults = .standard) {
        self.ephemeral = ephemeral
        self.storage = storage

        if !ephemeral {
            attemptToLoadFollowing()
        }
    }

    public func isFollowed(id: Int) -> Bool {
        return following.contains(id)
    }

    public func toggleFollowStatus(id: Int) {
        if following.contains(id) {
            following.remove(id)
        } else {
            following.insert(id)
        }

        if !ephemeral {
            saveFollowing()
        }
    }

    private func attemptToLoadFollowing() {
        if let followerIDs = storage.object(forKey: Self.storageKey) as? [Int] {
            let setOfFollowersIDs = Set(followerIDs)
            self.following = setOfFollowersIDs
        }
    }

    private func saveFollowing() {
        let arrayOfIds = Array(following)
        storage.set(arrayOfIds, forKey: Self.storageKey)
    }
}
