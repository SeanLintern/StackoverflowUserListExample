public protocol FollowService {
    func isFollowed(id: Int) -> Bool
    func toggleFollowStatus(id: Int)
}
