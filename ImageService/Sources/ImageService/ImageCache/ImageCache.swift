import UIKit

public protocol ImageCache {
    func fetchCachedImage(url: URL) -> UIImage?
    func cacheImage(image: UIImage, for url: URL)
}

public struct NSCacheBackedImageCache: ImageCache {
    private let internalCache: NSCache<NSString, UIImage> = .init()

    public init() {}

    public func fetchCachedImage(url: URL) -> UIImage? {
        return internalCache.object(forKey: NSString(string: url.absoluteString))
    }

    public func cacheImage(image: UIImage, for url: URL) {
        internalCache.setObject(image, forKey: NSString(string: url.absoluteString))
    }
}
