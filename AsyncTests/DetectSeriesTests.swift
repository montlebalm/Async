import XCTest

class DetectSeriesTests: XCTestCase {

  func testReturnsTruthyItem() {
    func trueIfHappy(text: String, callback: (NSError?, Bool) -> ()) {
      callback(nil, text == "happy")
    }

    Async.detectSeries(["happy", "sad"], iterator: trueIfHappy) { err, result in
      XCTAssertEqual(result, "happy")
    }
  }

  func testBreaksOnTruth() {
    var called = 0

    func throttle(speed: String, callback: (NSError?, Bool) -> ()) {
      if speed == "slow" {
        delay(100)
      }

      called += 1
      callback(nil, speed == "fast")
    }

    Async.detectSeries(["fast", "slow", "slow"], iterator: throttle) { err, result in
      XCTAssertLessThan(called, 3)
    }
  }

  func testRunsInSeries() {
    var called = 0

    func throttle(speed: String, callback: (NSError?, Bool) -> ()) {
      if speed == "slow" {
        delay(100)
      }

      called += 1
      callback(nil, speed == "fast")
    }

    Async.detectSeries(["slow", "slow", "fast"], iterator: throttle) { err, result in
      XCTAssertEqual(called, 3)
    }
  }

}
