//
//  MockURLSession.swift
//  SNMTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    var dataTaskCalled = false
    
    private let _configuration: URLSessionConfiguration
    init(configuration: URLSessionConfiguration) {
        self._configuration = configuration
    }
    
    override var configuration: URLSessionConfiguration {
        return _configuration
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCalled = true
        return URLSessionDataTask()
    }
}
