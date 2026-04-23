import Testing
@testable import FollowService

struct FollowServiceTests {
    @Test("Test storing following returns true")
    func ensureLocalFollowerStorageWorks() {
        let sut = LocalFollowService()
        let testID = 123
        sut.toggleFollowStatus(id: testID)
        #expect(sut.isFollowed(id: testID))
    }

    @Test("Test storing following returns false for different ID")
    func ensureLocalFollowerStorageDoesntReturnTrueForDifferentID() {
        let sut = LocalFollowService()
        let testID = 123
        let secondTestID = 234
        sut.toggleFollowStatus(id: testID)
        #expect(!sut.isFollowed(id: secondTestID))
    }
}
