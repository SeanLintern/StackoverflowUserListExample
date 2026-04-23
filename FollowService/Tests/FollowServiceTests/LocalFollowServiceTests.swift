import Foundation
import Testing
@testable import FollowService

struct LocalFollowServiceTests {
    @Test("Test storing following returns true")
    func ensureLocalFollowerStorageWorks() {
        let sut = LocalFollowService(ephemeral: true)
        let testID = 123
        sut.toggleFollowStatus(id: testID)
        #expect(sut.isFollowed(id: testID))
    }

    @Test("Test storing following returns false for different ID")
    func ensureLocalFollowerStorageDoesntReturnTrueForDifferentID() {
        let sut = LocalFollowService(ephemeral: true)
        let testID = 123
        let secondTestID = 234
        sut.toggleFollowStatus(id: testID)
        #expect(!sut.isFollowed(id: secondTestID))
    }

    @Test("Test ephemeral doesnt store follows")
    func ensureEphemeralSettingDoesntFetchFollowerIDs() {
        let sut = LocalFollowService(ephemeral: true)
        let testID = 123
        sut.toggleFollowStatus(id: testID)

        let secondSUTInstance = LocalFollowService(ephemeral: true)

        #expect(!secondSUTInstance.isFollowed(id: testID))
    }

    @Test("Test non Ephemeral Session stores IDs")
    func ensureEphemeralSettingDisabledAllowsRestorationOfFollowers() {
        let storageName = "\(Date.now.timeIntervalSince1970)"
        let storage = UserDefaults(suiteName: storageName)! // Ensure new suite every time

        defer {
            // Tidy up
            UserDefaults.standard.removePersistentDomain(forName: storageName)
        }

        let sut = LocalFollowService(storage: storage)
        let testID = 123
        sut.toggleFollowStatus(id: testID)

        let secondSUTInstance = LocalFollowService(storage: storage)

        #expect(secondSUTInstance.isFollowed(id: testID))
    }
}
