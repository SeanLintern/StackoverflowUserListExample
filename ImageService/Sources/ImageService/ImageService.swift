import UIKit

public protocol ImageService {
    func fetchImage(url: URL) async throws -> UIImage
}

public enum ImageServiceError: Error {
    case couldNotParseImageData
}
