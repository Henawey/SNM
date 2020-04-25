//
//  APIProviderTests.swift
//  NetworkingTests
//
//  Created by Ahmed Henawey on 9/15/19.
//  Copyright © 2019 Henawey. All rights reserved.
//

import XCTest
@testable import SNMP

class APIProviderTests: XCTestCase {

    func testError() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        // wait for mockCancellableTo call resume
        expectation.expectedFulfillmentCount = 2
        let mockCancellable = MockCancellable(resumeExpectation: expectation)
        let expectedError = MockError()
        
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.error(expectedError), cancellable: mockCancellable))
        
        provider.request(MockSpecification(.ok)) { result in
            switch result {
            case .success:
                XCTFail("testError should no go to success")
            case .failure(let error):
                switch error {
                case .error(let error) where error is MockError:
                    let error = error as! MockError
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTFail("error thrown is not .error")
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testInvalidStatusCode() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        // wait for mockCancellableTo call resume
        expectation.expectedFulfillmentCount = 2
        let mockCancellable = MockCancellable(resumeExpectation: expectation)
        
        let expectedCode = 300
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.invalidStatusCode(expectedCode), cancellable: mockCancellable))
        
        provider.request(MockSpecification(.ok)) { result in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                } catch let error as NetworkError {
                    XCTAssertEqual(error, .invalidStatusCode(expectedCode))
                    expectation.fulfill()
                    return
                } catch {}
                XCTFail("testError should no go to success")
            case .failure:
                XCTFail("testError should no go to failure")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testInvalidResponse() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        // wait for mockCancellableTo call resume
        expectation.expectedFulfillmentCount = 2
        let mockCancellable = MockCancellable(resumeExpectation: expectation)
        
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.invalidResponse, cancellable: mockCancellable))
        
        provider.request(MockSpecification(.ok)) { result in
            switch result {
            case .success:
                XCTFail("testError should no go to success")
            case .failure(let error):
                XCTAssertEqual(error, .invalidResponse)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testEmptySpecification() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.ok))
        
        provider.request(MockSpecification(.empty)) { result in
            switch result {
            case .success:
                XCTFail("testError should no go to success")
            case .failure(let error):
                XCTAssertEqual(error, .specificationNotValid)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testInvalidPath() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.ok))
        
        provider.request(MockSpecification(.error)) { result in
            switch result {
            case .success:
                XCTFail("testError should no go to success")
            case .failure(let error):
                XCTAssertEqual(error, .specificationNotValid)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testOkResponse() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        // wait for mockCancellableTo call resume
        expectation.expectedFulfillmentCount = 2
        let mockCancellable = MockCancellable(resumeExpectation: expectation)
        
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.ok, cancellable: mockCancellable))
        
        provider.request(MockSpecification(.ok)) { result in
            switch result {
            case .success(let response):
                do {
                    let result = try response.filterSuccessfulStatusCodes()
                    XCTAssertEqual(result.data, response.data)
                    expectation.fulfill()
                } catch {}
            case .failure:
                XCTFail("testError should go to success")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLazyRequestOkResponse() {
        let expectation = XCTestExpectation(description: "Should be Error of Type MockError")
        expectation.isInverted = true
        let mockCancellable = MockCancellable(resumeExpectation: expectation)
        let provider = APIProvider<MockSpecification>(requestHandler: MockRequestHandler(.ok, cancellable: mockCancellable))
        
        let cancellable = provider.lazyRequest(MockSpecification(.ok)) { result in
            XCTFail("testError should not call result closure")
        }
        cancellable?.cancel()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testURLSessionConfiguration() {
        let urlSession = MockURLSession(configuration: MockURLSessionConfiguration())
        let specification = MockSpecification(.ok)
        let provider = APIProvider<MockSpecification>(requestHandler: urlSession)
        _ = provider.lazyRequest(specification) { _ in }
        XCTAssertTrue(urlSession.dataTaskCalled)
    }
}
