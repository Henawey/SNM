//
//  Extensions.swift
//  NetworkingTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation
@testable import SNMP

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.specificationNotValid, .specificationNotValid):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.invalidStatusCode(let lCode), .invalidStatusCode(let rCode)):
            return lCode == rCode
        case (.error(let lError), .error(let rError)):
            guard let lError = lError as? MockError,
                let rError = rError as? MockError else {
                    return false
            }
            return lError === rError // same error
        default:
            return false
        }
    }
}
