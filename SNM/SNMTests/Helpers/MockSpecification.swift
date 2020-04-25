//
//  MockSpecification.swift
//  SNMTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation
@testable import SNM

struct MockSpecification: TargetSpecification {
    
    enum Scenario {
        case empty
        case error
        case ok
    }
    
    let scenario: Scenario
    
    init(_ scenario: Scenario) {
        self.scenario = scenario
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: String {
        switch scenario {
        case .empty:
            return ""
        case .ok, .error:
            return "https://google.com"
        }
    }
    
    var path: String? {
        switch scenario {
        case .empty:
            return ""
        case .error:
            return "path"
        case .ok:
            return "/path"
        }
    }
    
    var queryItems: [(key: String, value: String)]? {
        switch scenario {
        case .empty, .error:
            return nil
        default:
            return [("a","b")]
        }
    }
    
    var method: String {
        return "GET"
    }
}
