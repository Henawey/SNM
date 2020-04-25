//
//  NetworkProvider.swift
//  Networking
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

public protocol NetworkProvider {
    associatedtype Spec: TargetSpecification
    
    func request(_ specification: Spec,
         handler: @escaping (Result<Response, NetworkError>) -> ())
}
