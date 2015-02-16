import XCTest

class EachTests: XCTestCase {

  func testRunsInParallel() {
    var completedOrder: [String] = []

    func transform(text: String, callback: (NSError?) -> ()) {
      if text == "slow" {
        delay(100)
      }

      completedOrder.append(text)
      callback(nil)
    }

    Async.each(["slow", "fast"], transform: transform) { err in
      XCTAssertEqual(completedOrder, ["fast", "slow"])
    }
  }

}
