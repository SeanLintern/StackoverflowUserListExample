protocol FollowService {
    func isFollowed(id: Int) -> Bool
    func toggleFollowStatus(id: Int)
}

class LocalFollowService: FollowService {
    private var following: Set<Int> = []

    func isFollowed(id: Int) -> Bool {
        return following.contains(id)
    }

    func toggleFollowStatus(id: Int) {
        if following.contains(id) {
            following.remove(id)
        } else {
            following.insert(id)
        }
    }
}
