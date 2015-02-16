import XCTest

class ReduceTests: XCTestCase {

  func testPreservesOrder() {
    func iterator(current: String, item: String, complete: (NSError?, String) -> ()) {
      complete(nil, current + item)
    }

    Async.reduce(["one", "two"], initial: "", iterator: iterator) { err, reduction in
      XCTAssertEqual(reduction, "onetwo")
    }
  }

  func testAllowsTypeMismatch() {
    func iterator(current: String, item: Int, complete: (NSError?, String) -> ()) {
      complete(nil, current + String(item))
    }

    Async.reduce([1, 2], initial: "", iterator: iterator) { err, reduction in
      XCTAssertEqual(reduction, "12")
    }
  }

}
