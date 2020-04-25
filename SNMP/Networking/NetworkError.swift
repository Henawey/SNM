//
//  NetworkError.swift
//  Networking
//
//  Created by Ahmed Henawey on 10/27/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

public enum NetworkError: Swift.Error {
    case specificationNotValid
    case invalidResponse
    case timeout
    case invalidStatusCode(_ code: Int)
    case error(_ error: Error)
}
