//
//  NetworkProvider.swift
//  Networking
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import Foundation

public final class APIProvider<Spec: TargetSpecification>: NetworkProvider {
    
    private let requestHandler: RequestHandler
    
    public init(requestHandler: RequestHandler = URLSession.shared) {
        requestHandler.requestConfiguration.waitsForConnectivity = true
        requestHandler.requestConfiguration.timeoutIntervalForResource = 500
        self.requestHandler = requestHandler
    }
    
    private func sendRequest(_ request: URLRequest,
                                 _ handler: @escaping (Result<Response, NetworkError>) -> ()) -> Cancellable {
        
        return requestHandler.request(request) { (data, response, error) in
            if let error = error {
                return handler(.failure(.error(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return handler(.failure(.invalidResponse))
            }
            
            let response = Response(httpResponse: httpResponse, data: data)
            return handler(.success(response))
        }
    }
    
    public func lazyRequest(_ specification: Spec, handler: @escaping (Result<Response, NetworkError>) -> ()) -> Cancellable? {
        
        guard !specification.baseURL.isEmpty else {
            handler(.failure(.specificationNotValid))
            return nil
        }
        
        var components = URLComponents(string: specification.baseURL)
        
        if let path = specification.path {
            components?.path = path
        }
        
        components?.queryItems = specification.queryItems?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components?.url else {
            handler(.failure(.specificationNotValid))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = specification.headers
        request.httpMethod = specification.method
        
        return sendRequest(request, handler)
    }
    
    public func request(_ specification: Spec, handler: @escaping (Result<Response, NetworkError>) -> ()){
        lazyRequest(specification, handler: handler)?
            .resume()
    }
}
