import FollowService
import Foundation
import UserService
import UIKit

class UserCell: UITableViewCell {
    private var viewModel: UserCellViewModel?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onDeque()
    }

    func onDeque() {
        
    }

    func configure(viewModel: UserCellViewModel) {
        self.viewModel = viewModel
    }
}
