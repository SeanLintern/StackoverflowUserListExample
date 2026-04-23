import FollowService
import Foundation
import UserService

struct UserCellViewModel {
    let user: StackOverflowUser

    private let followService: FollowService

    init(user: StackOverflowUser, followService: FollowService) {
        self.user = user
        self.followService = followService
    }

    func isFollowing() -> Bool {
        followService.isFollowed(id: user.id)
    }

    func followPress() {
        followService.toggleFollowStatus(id: user.id)
    }
}
