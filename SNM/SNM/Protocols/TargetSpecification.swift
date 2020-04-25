//
//  TargetSpecification.swift
//  SNM
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

public protocol TargetSpecification {
    var baseURL: String { get }
    var path: String? { get }
    var queryItems: [(key: String, value: String)]? { get }
    var headers: [String: String]? { get }
    var method: String { get }
}
