//
//  MockCancellable.swift
//  NetworkingTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation
import class XCTest.XCTestExpectation
@testable import SNMP

struct MockCancellable: Cancellable {
    
    var resumeExpectation: XCTestExpectation? = nil
    var cancelExpectation: XCTestExpectation? = nil
    var resumeBlock: (() -> ())? = nil
    
    init(resumeExpectation: XCTestExpectation? = nil,
         cancelExpectation: XCTestExpectation? = nil,
         resumeBlock: (() -> ())? = nil) {
        self.resumeExpectation = resumeExpectation
        self.cancelExpectation = cancelExpectation
        self.resumeBlock = resumeBlock
    }
    
    func resume() {
        resumeExpectation?.fulfill()
        resumeBlock?()
    }
    
    func cancel() {
        cancelExpectation?.fulfill()
    }
}
