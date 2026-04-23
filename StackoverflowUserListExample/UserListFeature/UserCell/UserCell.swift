import FollowService
import Foundation
import UserService
import UIKit

class UserCell: UITableViewCell {
    private var viewModel: UserCellViewModel?

    private lazy var containerStack: UIStackView = {
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .top
        hStack.spacing = 16.0
        hStack.addArrangedSubview(profileImageView)
        hStack.addArrangedSubview(detailsStack)
        hStack.addArrangedSubview(followButton)
        return hStack
    }()

    private lazy var detailsStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .top
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(reputationLabel)
        return vStack
    }()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var reputationLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var followButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            self?.followButtonPressed()
        })
        return button
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onDeque()
    }

    func onDeque() {
        contentView.addSubview(containerStack)
        NSLayoutConstraint.activate([
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
        ])

        NSLayoutConstraint.activate([
            followButton.widthAnchor.constraint(equalToConstant: 30),
            followButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    override func prepareForReuse() {
        viewModel?.imageUpdateHandler = nil

        super.prepareForReuse()
    }

    func configure(viewModel: UserCellViewModel) {
        self.viewModel = viewModel

        viewModel.imageUpdateHandler = { [weak self] image in
            self?.profileImageView.image = image
        }

        nameLabel.text = viewModel.user.name
        reputationLabel.text = "Reputation: \(viewModel.user.reputation)"
        profileImageView.image = viewModel.userImage
        updateFollowButtonState()
    }

    private func updateFollowButtonState() {
        if viewModel?.isFollowing() ?? false {
            followButton.setImage(UIImage(systemName: "person.badge.minus"), for: [])
        } else {
            followButton.setImage(UIImage(systemName: "person.fill.badge.plus"), for: [])
        }
    }

    private func followButtonPressed() {
        viewModel?.followPress()
        updateFollowButtonState()
    }
}
