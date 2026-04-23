import FollowService
import Foundation
import ImageService
import UIKit
import UserService

class UserCellViewModel {
    typealias UserCellImageUpdateCallback = (UIImage?) -> Void

    let user: StackOverflowUser

    var imageUpdateHandler: UserCellImageUpdateCallback?

    private(set) var userImage: UIImage? {
        didSet {
            imageUpdateHandler?(userImage)
        }
    }

    private let followService: FollowService
    private let imageService: ImageService

    init(
        user: StackOverflowUser,
        followService: FollowService,
        imageService: ImageService
    ) {
        self.user = user
        self.followService = followService
        self.imageService = imageService

        preloadImage()
    }

    func isFollowing() -> Bool {
        followService.isFollowed(id: user.id)
    }

    func followPress() {
        followService.toggleFollowStatus(id: user.id)
    }

    private func preloadImage() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let image = try await imageService.fetchImage(url: user.profileImage)
            userImage = image
        }
    }
}
