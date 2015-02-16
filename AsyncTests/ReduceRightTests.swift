import XCTest

class ReduceRightTests: XCTestCase {

  func testPreservesOrder() {
    func iterator(current: String, item: String, complete: (NSError?, String) -> ()) {
      complete(nil, current + item)
    }

    Async.reduceRight(["one", "two"], initial: "", iterator: iterator) { err, reduction in
      XCTAssertEqual(reduction, "twoone")
    }
  }

  func testAllowsTypeMismatch() {
    func iterator(current: String, item: Int, complete: (NSError?, String) -> ()) {
      complete(nil, current + String(item))
    }

    Async.reduceRight([1, 2], initial: "", iterator: iterator) { err, reduction in
      XCTAssertEqual(reduction, "21")
    }
  }

}
