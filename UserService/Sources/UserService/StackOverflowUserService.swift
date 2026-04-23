import Foundation
import Networking

struct StackOverflowUserService: UserService {
    private let client: Client

    private static let baseURL = URL(string: "https://api.stackexchange.com/2.3/users")!

    private static let decoder: JSONDecoder = .init()

    init(client: Client = RemoteClient()) {
        self.client = client
    }

    func topTwentyStackOverflowUsersByReputation() async throws -> [StackOverflowUser] {
        return try await fetchUsers(page: 1, pageSize: 20, order: "desc", sort: "reputation")
    }

    private func fetchUsers(page: Int, pageSize: Int, order: String, sort: String) async throws -> [StackOverflowUser] {
        var base = URLComponents(url: Self.baseURL, resolvingAgainstBaseURL: false)

        let query = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pagesize", value: String(pageSize)),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "site", value: "stackoverflow"),
        ]

        base?.queryItems = query

        guard let requestURL = base?.url else {
            throw UserServiceError.malformedRequest
        }

        let list: StackOverflowUserList = try await peformDataTask(
            with: requestURL,
            decoder: Self.decoder
        )

        return list.items
    }

    private func peformDataTask<T: Decodable>(with url: URL, decoder: JSONDecoder) async throws -> T {
        let data = try await client.data(from: url).0
        let items = try decoder.decode(T.self, from: data)
        return items
    }
}
