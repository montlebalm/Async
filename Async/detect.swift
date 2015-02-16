import Foundation

extension Async {

  class func detect<I>(
    items: [I],
    iterator: (I, (NSError?, Bool) -> ()) -> (),
    complete: (NSError?, I) -> ()
  ) {
    var queue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT)

    _detect(items, complete: complete) { item, next in
      dispatch_async(queue) {
        iterator(item, next)
      }
    }
  }

}
