import Foundation

public protocol NetworkClient: Sendable {
  func data(from url: URL) async throws -> (Data, URLResponse)
}

