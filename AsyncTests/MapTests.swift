import XCTest

class MapTests: XCTestCase {

  func testPreservesOrder() {
    func double(num: Int, complete: (NSError?, Int) -> ()) {
      complete(nil, num * 2)
    }

    Async.map([1, 2], iterator: double) { err, results in
      XCTAssertEqual(results, [2, 4])
    }
  }

  func testRunsInParallel() {
    var completedOrder: [String] = []

    func throttle(text: String, callback: (NSError?, String) -> ()) {
      if text == "slow" {
        delay(100)
      }

      completedOrder.append(text)
      callback(nil, text)
    }

    Async.map(["slow", "fast"], iterator: throttle) { err, results in
      XCTAssertEqual(completedOrder, ["fast", "slow"])
    }
  }

}
