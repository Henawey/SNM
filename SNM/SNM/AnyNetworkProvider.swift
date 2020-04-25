//
//  AnyNetworkProvider.swift
//  SNM
//
//  Created by Ahmed Henawey on 12/8/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

// To help the compiler bypassing these protocol limitations you need to create a wrapper class. This helps to make the generic type of the protocol concrete.

///An instance of AnyNetworkProvider forwards request operation to an underlying  networkProvider having the same TargetSpec type, hiding the specifics of the underlying networkProvider.
struct AnyNetworkProvider<TargetSpec: TargetSpecification>: NetworkProvider {
    public typealias Spec = TargetSpec
    
    private let _request: (_ specification: TargetSpec, _ handler: @escaping (Result<Response, NetworkError>) -> Void) -> Void
    
    public init<Provider: NetworkProvider>(_ networkProvider: Provider) where Provider.Spec == TargetSpec {
        _request = networkProvider.request
    }
    
    public func request(_ specification: TargetSpec, handler: @escaping (Result<Response, NetworkError>) -> ()) {
        _request(specification, handler)
    }
}
