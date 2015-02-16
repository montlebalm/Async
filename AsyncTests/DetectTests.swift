import XCTest

class DetectTests: XCTestCase {

  func testReturnsTruthyItem() {
    func trueIfHappy(text: String, callback: (NSError?, Bool) -> ()) {
      callback(nil, text == "happy")
    }

    Async.detect(["happy", "sad"], iterator: trueIfHappy) { err, result in
      XCTAssertEqual(result, "happy")
    }
  }

  func testBreaksOnTruth() {
    var called = 0

    func sadSlow(text: String, callback: (NSError?, Bool) -> ()) {
      if text == "sad" {
        delay(100)
      }

      called += 1
      callback(nil, text == "happy")
    }

    Async.detect(["happy", "sad", "sad"], iterator: sadSlow) { err, results in
      XCTAssertLessThan(called, 3)
    }
  }

}
