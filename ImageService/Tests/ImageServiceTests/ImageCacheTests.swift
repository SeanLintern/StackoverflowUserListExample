import Testing
import UIKit
@testable import ImageService

struct ImageCacheTests {
    @Test("Cache returns correct image")
    func cacheImageAndThenFetchGetsCorrectImage() async throws {
        let sut = NSCacheBackedImageCache()
        let url = URL.applicationDirectory
        let uiImage = UIImage(systemName: "pencil")!
        sut.cacheImage(image: uiImage, for: url)
        let fetched = sut.fetchCachedImage(url: url)
        #expect(fetched == uiImage)
    }
}
