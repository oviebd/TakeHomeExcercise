//
//  RecipeApiTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 29/1/25.
//

@testable import TakeHome
import XCTest

final class RecipeApiTests: XCTestCase {
   
    lazy var api: MockRecipeAPIService = {
        let httpClient = URLSessionHTTPClient(session: mockSession)
        return MockRecipeAPIService(session: mockSession, url: dummyRecipeUrl)
    }()

    override func tearDown() {
        MockURLProtocol.resetStub()
        super.tearDown()
    }

    let successResponse = getSuccessResponse(with: dummyRecipeUrl)
    
    func test_GetRecipes_SuccessWithValidData () async throws {
       
        let mockData = validRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: nil)
        let exp = expectation(description: "waiting for completion")
        
        let result = await api.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(result.data?.count ?? 0, 1)
        XCTAssertEqual(result.data?[0].name, "Bakewell Tart")
    }
    
    func test_GetRecipes_FailedWithError () async throws {
       
        let mockData = validRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: error)
        let exp = expectation(description: "waiting for completion")
        
        let result = await api.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertNil(result.data)
        XCTAssertNotNil(result.error)
    }
    
    func test_GetRecipes_SuccessWithValidEmptyData () async throws {
     
        let mockData = validRecipeListJsonWithEmptyList().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: nil)
        let exp = expectation(description: "waiting for completion")
        
        let result = await api.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(result.data?.count ?? 0, 0)
    }
    
    func test_GetRecipes_FailedWithMalformedData () async throws {
        let mockData = malformedRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: nil)
        let exp = expectation(description: "waiting for completion")
        
        let result = await api.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(result.data?.count ?? 0, 0)
        XCTAssertNotNil(result.error)
    }
}


