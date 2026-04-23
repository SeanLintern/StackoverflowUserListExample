import FollowService
import Foundation
import UserService

class UserListViewModel {
    typealias UserListViewModelStateChangeHandler = ((ViewState) -> Void)

    enum ViewState {
        case uninitialised
        case loading
        case success
        case error
    }

    private let userService: UserService
    private let followService: FollowService

    private(set) var state: ViewState = .uninitialised {
        didSet {
            viewStateChangeHandler?(state)
        }
    }

    private(set) var rows: [UserCellViewModel] = []

    var viewStateChangeHandler: UserListViewModelStateChangeHandler?

    init(userService: UserService, followService: FollowService) {
        self.userService = userService
        self.followService = followService
    }

    func viewDidLoad() {
        fetchTopTwenty()
    }

    func refresh() {
        fetchTopTwenty()
    }

    private func fetchTopTwenty() {
        Task {
            do {
                let users = try await userService.topTwentyStackOverflowUsersByReputation()
                let viewModels = users.map { UserCellViewModel(user: $0, followService: followService)}
                rows = viewModels

                if rows.isEmpty {
                    state = .error
                } else {
                    state = .success
                }

            } catch {
                state = .error // Could pass error to screen for more clarity
            }
        }
    }
}
