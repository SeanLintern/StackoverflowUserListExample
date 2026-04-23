import Foundation

public struct MockClient: Client {
    public enum MockNetworkError: Error {
        case noScenarioSet
    }

    private let data: Data?
    private let errorCode: Int?
    private let thrownError: Error?

    public init(
        data: Data? = nil,
        errorCode: Int? = nil,
        thrownError: Error? = nil
    ) {
        self.data = data
        self.errorCode = errorCode
        self.thrownError = thrownError
    }

    public func data(from url: URL) async throws -> (Data, URLResponse) {
        if let data {
            return (data, .init())
        } else if let errorCode {
            return (
                .init(),
                HTTPURLResponse(
                    url: url,
                    statusCode: errorCode,
                    httpVersion: nil,
                    headerFields: [:]
                )!
            )
        } else if let thrownError {
            throw thrownError
        } else {
            throw MockNetworkError.noScenarioSet
        }
    }
}
