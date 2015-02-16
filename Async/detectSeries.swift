import Foundation

extension Async {

  class func detectSeries<I>(
    items: [I],
    iterator: (I, (NSError?, Bool) -> ()) -> (),
    complete: (NSError?, I) -> ()
  ) {
    var queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)

    _detect(items, complete: complete) { item, next in
      dispatch_sync(queue) {
        iterator(item, next)
      }
    }
  }

}
