import XCTest
import ViewInspector
@testable import LittleThings

extension ProfileHeader: Inspectable {}

class ProfileHeaderTests: XCTestCase {
    private let sut = ProfileHeader(picture: "")

    func testHasText() throws {
        XCTAssertEqual(try self.sut.inspect().text().string(), "Profile")
    }
}
