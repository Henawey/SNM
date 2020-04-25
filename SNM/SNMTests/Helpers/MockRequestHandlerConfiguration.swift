//
//  MockRequestHandlerConfiguration.swift
//  SNMTests
//
//  Created by Ahmed Henawey on 10/30/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation
@testable import SNM

class MockRequestHandlerConfiguration: RequestHandlerConfiguration {
    var waitsForConnectivity: Bool = true
    
    var timeoutIntervalForResource: TimeInterval = 300
}
