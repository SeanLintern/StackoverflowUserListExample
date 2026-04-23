import Foundation
import UserService

class UserListViewModel {
    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }
}
