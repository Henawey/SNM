//
//  Response.swift
//  Networking
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

public struct Response {
    public let data: Data?
    private let httpResponse: HTTPURLResponse
    
    public init(httpResponse: HTTPURLResponse, data: Data?) {
        self.httpResponse = httpResponse
        self.data = data
    }
    
    public func filterSuccessfulStatusCodes(_ statusCodes: ClosedRange<Int> = 200...299) throws -> Self {
        guard statusCodes.contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        return self
    }
}
