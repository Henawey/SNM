//
//  MockRequestHandler.swift
//  SNMTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation
@testable import SNM

class MockRequestHandler: RequestHandler {
    var requestConfiguration: RequestHandlerConfiguration = MockRequestHandlerConfiguration()
    
    enum Scenario {
        case error(_ expectedError: Error)
        case invalidResponse
        case invalidStatusCode(_ code: Int)
        case ok
    }
    
    let scenario: Scenario
    var cancellable: MockCancellable
    
    init(_ scenario: Scenario, cancellable: MockCancellable = MockCancellable()) {
        self.scenario = scenario
        self.cancellable = cancellable
    }
    
    func request(_ request: URLRequest, responseHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> Cancellable {
        cancellable.resumeBlock = {
            switch self.scenario {
            case .error(let error):
                responseHandler(nil, nil, error)
            case .invalidResponse:
                let response = URLResponse(url: URL(string: "test")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
                responseHandler(nil, response, nil)
            case .invalidStatusCode(let code):
                let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: code, httpVersion: nil, headerFields: nil)
                responseHandler(nil, response, nil)
            case .ok:
                let data = Data()
                let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
                responseHandler(data, response, nil)
            }
        }
        
        return cancellable
    }
}
