import XCTest

class EachSeriesTests: XCTestCase {

  func testRunsInSeries() {
    var completedOrder: [String] = []

    func transform(text: String, callback: (NSError?) -> ()) {
      if text == "slow" {
        delay(100)
      }

      completedOrder.append(text)
      callback(nil)
    }

    Async.eachSeries(["slow", "fast"], transform: transform) { err in
      XCTAssertEqual(completedOrder, ["slow", "fast"])
    }
  }

}
