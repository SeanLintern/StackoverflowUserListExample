import Foundation
import Testing
@testable import NetworkingTestSupport

struct MockNetworkClientTests {
    @Test("When given test data - same data is returned")
    func ensureGivenDataIsReturned() async throws {
        let testData = "test data".data(using: .utf8)!
        let sut = MockClient(data: testData)
        let requestData = try await sut.data(from: .applicationDirectory).0
        #expect(testData == requestData)
    }

    @Test("When given a status code - same status code is returned")
    func ensureGivenStatusCodeIsReturned() async throws {
        let testCode = 500
        let sut = MockClient(errorCode: 500)
        let response = try await sut.data(from: .applicationDirectory).1 as? HTTPURLResponse
        #expect(response?.statusCode == testCode)
    }

    @Test("When given a thrown error - same error is thrown")
    func ensureGivenThrownErrorIsReturned() async throws {
        enum TestError: Error {
            case testThrownError
        }

        let sut = MockClient(thrownError: TestError.testThrownError)

        await #expect(throws: TestError.testThrownError) {
            try await sut.data(from: .applicationDirectory)
        }
    }

    @Test("When given no scenario - the mock network error throws")
    func ensureDefaultErrorIsThrownWhenNoScenarioGiven() async throws {
        let sut = MockClient()

        await #expect(throws: MockClient.MockNetworkError.noScenarioSet) {
            try await sut.data(from: .applicationDirectory)
        }
    }
}
