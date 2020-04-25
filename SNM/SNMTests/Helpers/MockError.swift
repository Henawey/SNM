//
//  MockError.swift
//  SNMTests
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

class MockError: Error, Equatable {
    let localizedMessage: String
    
    init(localizedMessage: String = "") {
        self.localizedMessage = localizedMessage
    }
    static func == (lhs: MockError, rhs: MockError) -> Bool {
        return lhs === rhs
    }
    
    var localizedDescription: String {
        return localizedMessage
    }
}
