import Foundation

public struct RemoteClient: Client {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func data(from url: URL) async throws -> (Data, URLResponse) {
        try await session.data(from: url, delegate: nil)
    }
}
