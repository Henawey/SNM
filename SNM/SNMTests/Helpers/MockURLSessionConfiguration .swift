//
//  MockURLSessionConfiguration .swift
//  SNMTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

class MockURLSessionConfiguration: URLSessionConfiguration {
    private var _waitsForConnectivity = false
    private var _timeoutIntervalForResource: TimeInterval = 2000
    override var waitsForConnectivity: Bool {
        set {
            _waitsForConnectivity = newValue
        }
        
        get {
            _waitsForConnectivity
        }
    }
    
    override var timeoutIntervalForResource: TimeInterval {
        set {
            _timeoutIntervalForResource = newValue
        }
        
        get {
            _timeoutIntervalForResource
        }
    }
}
