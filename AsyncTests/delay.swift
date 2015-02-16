//
//  wait.swift
//  Async
//
//  Created by Chris Montrois on 2/15/15.
//  Copyright (c) 2015 bigevilrobot. All rights reserved.
//

import Foundation

/**
  Wait for the specified period of time
  :param: duration The time to wait in milliseconds
*/
public func delay(duration: Int) {
  usleep(useconds_t(duration * 1000))
}