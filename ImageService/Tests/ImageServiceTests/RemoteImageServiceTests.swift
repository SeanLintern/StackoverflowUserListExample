import Testing
import UIKit
import Networking
@testable import ImageService

struct RemoteImageServiceTests {
    @Test("Image is returned")
    func correctImageIsReturned() async throws {
        let testImage = UIImage(systemName: "pencil")!
        let testImageData = testImage.pngData()!
        let client = MockClient(data: testImageData)
        let url = URL.applicationDirectory
        let sut = RemoteImageService(client: client)
        let result = try await sut.fetchImage(url: url)
        // because of metadata etc this expectes the exact same image data size
        #expect(result.pngData()!.count == testImageData.count)
    }

    @Test("Ensure we get image from cache before using client")
    func correctImageIsReturnedFromCacheBeforeHittingClient() async throws {
        let testImage = UIImage(systemName: "pencil")!
        let testImageData = testImage.pngData()!
        let testImageNoMeta = UIImage(data: testImageData)!
        let url = URL.applicationDirectory

        // If the client requested the image it would cause a 500
        let client = MockClient(errorCode: 500)

        let cache = NSCacheBackedImageCache()
        cache.cacheImage(image: testImageNoMeta, for: url)

        // Injected cache which already has an image ready
        let sut = RemoteImageService(client: client, cache: cache)

        let result = try await sut.fetchImage(url: url)
        // because of metadata etc this expectes the exact same image data size
        #expect(result.pngData()!.count == testImageData.count)
    }
}
