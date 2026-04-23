import UIKit

protocol ImageService {
    func fetchImage(url: URL) async throws -> UIImage
}

enum ImageServiceError: Error {
    case couldNotParseImageData
}

