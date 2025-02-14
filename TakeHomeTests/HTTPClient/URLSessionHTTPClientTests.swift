//
//  URLSessionHTTPClientTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 11/2/25.
//

@testable import TakeHome
import XCTest

final class URLSessionHTTPClientTests: XCTestCase {

    func test_GetResponse_SuccessWithSuccessResponse() async {
       
        let httpClient = makeSUT()
        let url = URL(string: greenImageDataKey)!
        let response = getSuccessResponse(with: url)
        MockURLProtocol.stubRequest(response: response, data: Data(), error: nil)
     
        let exp = expectation(description: "waiting for completion")
        let result = await httpClient.getAPIResponse(from: url)
        exp.fulfill()
           await fulfillment(of: [exp], timeout: 1.0)
        switch result {
        case .success (let data):
            XCTAssertNotNil(data)
        case .failure:
            XCTFail("Expected success insted get \(error)")
        }
    }
    
    func test_GetResponse_FailedWithError() async {
       
        let httpClient = makeSUT()
        let url = URL(string: greenImageDataKey)!
        let response = getSuccessResponse(with: url)

        MockURLProtocol.stubRequest(response: response, data: Data(), error: error)
        let exp = expectation(description: "waiting for completion")
        let result = await httpClient.getAPIResponse(from: url)
        exp.fulfill()
           await fulfillment(of: [exp], timeout: 1.0)
        
        switch result {
        case .success (let data):
            XCTFail("Expected Failed insted get \(data)")
        case .failure (let fetchedError):
            XCTAssertEqual(error.domain, (fetchedError as NSError).domain)
            XCTAssertEqual(error.code, (fetchedError as NSError).code)
        }
    }
    
    func test_GetResponse_SuccessWithEmptyData() async {
       
        let httpClient = makeSUT()
        let url = URL(string: greenImageDataKey)!
        let response = getSuccessResponse(with: url)
        let exp = expectation(description: "waiting for completion")
        MockURLProtocol.stubRequest(response: response, data: nil, error: nil)

        let result = await httpClient.getAPIResponse(from: url)
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        switch result {
        case .success(let data):
            XCTAssertEqual(data.data.count,0)
        case .failure:
            XCTFail("Expected success insted get \(error)")
        }
    }

    func makeSUT() -> HTTPClient {
        return URLSessionHTTPClient(session: mockSession)
    }
}
