import UIKit

protocol ImageCache {
    func fetchCachedImage(url: URL) -> UIImage?
    func cacheImage(image: UIImage, for url: URL)
}

struct NSCacheBackedImageCache: ImageCache {
    private let internalCache: NSCache<NSString, UIImage> = .init()

    func fetchCachedImage(url: URL) -> UIImage? {
        return internalCache.object(forKey: NSString(string: url.absoluteString))
    }

    func cacheImage(image: UIImage, for url: URL) {
        internalCache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
}
