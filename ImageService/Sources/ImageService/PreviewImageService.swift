import UIKit

public struct PreviewImageService: ImageService {
    public init() {}

    public func fetchImage(url: URL) async throws -> UIImage {
        return UIImage(systemName: "person.fill")!
    }
}
