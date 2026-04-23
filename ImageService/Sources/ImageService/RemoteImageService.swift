import Networking
import UIKit

struct RemoteImageService: ImageService {
    private let client: Client
    private let cache: ImageCache

    init(
        client: Client = RemoteClient(),
        cache: ImageCache = NSCacheBackedImageCache()
    ) {
        self.client = client
        self.cache = cache
    }

    func fetchImage(url: URL) async throws -> UIImage {
        if let image = cache.fetchCachedImage(url: url) {
            return image
        }

        let data = try await client.data(from: url).0

        if let image = UIImage(data: data) {
            cache.cacheImage(image: image, for: url)
            return image
        }

        throw ImageServiceError.couldNotParseImageData
    }
}
