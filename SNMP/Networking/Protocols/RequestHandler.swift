//
//  RequestHandler.swift
//  Networking
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

public protocol RequestHandlerConfiguration: AnyObject {
    var waitsForConnectivity: Bool { get set }
    var timeoutIntervalForResource: TimeInterval { get set }
}
extension URLSessionConfiguration: RequestHandlerConfiguration {}

public protocol RequestHandler {
    var requestConfiguration: RequestHandlerConfiguration { get }
    func request(_ request: URLRequest, responseHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> Cancellable
}
extension URLSession: RequestHandler {
    public var requestConfiguration: RequestHandlerConfiguration { configuration }
    
    public func request(_ request: URLRequest, responseHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> Cancellable {
        return dataTask(with: request, completionHandler: responseHandler)
    }
}

public protocol Cancellable {
    func resume()
    func cancel()
}
extension URLSessionDataTask: Cancellable {}
