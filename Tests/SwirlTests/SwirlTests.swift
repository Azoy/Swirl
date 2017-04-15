import XCTest
@testable import Swirl

class SwirlTests: XCTestCase {
    func testExample() {

      let float: [UInt8] = [131, 70, 64, 9, 33, 250, 252, 139, 0, 122]
      let smallInt: [UInt8] = [131, 97, 16]
      let int: [UInt8] = [131, 98, 0, 0, 16, 2]
      let atom: [UInt8] = [131, 100, 0, 12, 72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 33]
      let list: [UInt8] = [131, 108, 0, 0, 0, 3, 97, 1, 97, 2, 97, 3, 106]
      let map: [UInt8] = [131, 116, 0, 0, 0, 1, 100, 0, 1, 97, 97, 150]

      XCTAssertEqual(try! Swirl.unpack(float) as! Double, 3.141592, "Floats were not the same")
      XCTAssertEqual(try! Swirl.unpack(smallInt) as! UInt8, 16, "UInt8s were not the same")
      XCTAssertEqual(try! Swirl.unpack(int) as! Int, 4098, "Floats were not the same")
      XCTAssertEqual(try! Swirl.unpack(atom) as! String, "Hello world!", "Atoms were not the same")
      XCTAssertEqual(try! Swirl.unpack(list) as! [UInt8], [1, 2, 3], "Lists were not the same")
      XCTAssertEqual(try! Swirl.unpack(map) as! [String: UInt8], ["a": 150], "Maps were not the same")
    }


    static var allTests = [
      ("testExample", testExample),
    ]
}
