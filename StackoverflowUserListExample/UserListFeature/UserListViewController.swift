import FollowService
import UIKit
import UserService

class UserListViewController: UIViewController {

    private let viewModel: UserListViewModel

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        return table
    }()

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    private lazy var errorMessage: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            self?.viewModel.refresh()
        })
        button.setTitle("An error has occurred\nTap to try again.", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: [])
        button.isHidden = true
        return button
    }()

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(viewModel:) instead.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])

        tableView.register(UserCell.self, forCellReuseIdentifier: String(describing: UserCell.self))

        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        view.addSubview(errorMessage)
        NSLayoutConstraint.activate([
            errorMessage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        bindViewModel()

        viewModel.viewDidLoad()
    }

    private func bindViewModel() {
        viewModel.viewStateChangeHandler = { [weak self] _ in
            self?.stateDidChange()
        }
    }

    private func stateDidChange() {
        loader.stopAnimating()

        switch viewModel.state {
        case .uninitialised:
            break
        case .loading:
            loader.startAnimating()
        case .success:
            tableView.reloadData()
        case .error:
            errorMessage.isHidden = false
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.state == .success {
            return viewModel.rows.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UserCell.self),
            for: indexPath
        ) as? UserCell else {
            fatalError("Failed to dequeueReusableCell")
        }

        cell.configure(viewModel: viewModel.rows[indexPath.row])

        return cell
    }
}

#Preview("Success") {
    UserListViewController(
        viewModel: .init(
            userService: PreviewUserService(),
            followService: LocalFollowService(
                ephemeral: true,
                storage: .init(
                    suiteName: String(describing: UserListViewController.self)
                ) ?? .standard
            )
        )
    )
}

#Preview("Error") {
    UserListViewController(
        viewModel: .init(
            userService: PreviewUserService(shouldFailure: true),
            followService: LocalFollowService(
                ephemeral: true,
                storage: .init(
                    suiteName: String(describing: UserListViewController.self)
                ) ?? .standard
            )
        )
    )
}
