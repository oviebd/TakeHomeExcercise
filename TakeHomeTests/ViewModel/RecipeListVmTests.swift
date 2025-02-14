//
//  RecipeListVmTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 13/2/25.
//

@testable import TakeHome
import XCTest

final class RecipeListVmTests: XCTestCase {
    
    let successResponse = getSuccessResponse(with: dummyRecipeUrl)
    
//    override class func setUp() {
//        MockURLProtocol.resetStub()
//    }
//    override func tearDown() {
//        MockURLProtocol.resetStub()
//        super.tearDown()
//    }
    
    func test_getRecipe_RecipeListWillSetForNotEmptyValidRecipeList() async {
        
        let (api,vm) = makeSUT()
        let mockData = validRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: nil)
       
        let exp = expectation(description: "waiting for completion")
        await vm.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertGreaterThan(vm.recipeList.count, 0)
        XCTAssertNil(vm.errorMessage)
    }
    
    func test_getRecipe_ErrorMessageWillNotNilForEmptyRecipeList() async {
        
        let (api,vm) = makeSUT()
        let mockData = validRecipeListJsonWithEmptyList().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: nil)
        
        let exp = expectation(description: "waiting for completion")
        await vm.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(vm.recipeList.count, 0)
        XCTAssertNotNil(vm.errorMessage)
    }
    
    func test_getRecipe_ErrorMessageWillNotNilForInvalidRecipeData() async {
        
        let (api,vm) = makeSUT()
        let mockData = malformedRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: nil)
       
        let exp = expectation(description: "waiting for completion")
        await vm.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(vm.recipeList.count, 0)
        XCTAssertNotNil(vm.errorMessage)
    }
    
    
    func test_getRecipe_ErrorMessageWillNotNilForApiError () async {
        
        let (api,vm) = makeSUT()
        let mockData = validRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: error)
        
        let exp = expectation(description: "waiting for completion")
        await vm.getRecipes()
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(vm.recipeList.count, 0)
        XCTAssertNotNil(vm.errorMessage)
    }

    func test_getRecipeTwice_ErrorMessageWillNotNilAfterSuccessfullyFetchedNotEmptyData() async {
        
        let (api,vm) = makeSUT()
        let mockData = validRecipeListJsonWithSingleRecipe().data(using: .utf8)!
        api.stub(response: successResponse, data: mockData, error: error)
        
        
        let exp1 = expectation(description: "waiting for completion")
        let exp2 = expectation(description: "waiting for completion 1")
        await vm.getRecipes()
        exp1.fulfill()
       
        await fulfillment(of: [exp1], timeout: 1.0)
        XCTAssertEqual(vm.recipeList.count, 0)
        XCTAssertNotNil(vm.errorMessage)
        
        api.stub(response: successResponse, data: mockData, error: nil)
        await vm.getRecipes()
        exp2.fulfill()
        await fulfillment(of: [exp2], timeout: 1.0)
        
        XCTAssertGreaterThan(vm.recipeList.count, 0)
        XCTAssertNil(vm.errorMessage)
    }
    
    
    // Helpers
    func makeSUT() -> ( apiService : MockRecipeAPIService, vm : RecipeListVM ) {
        let apiService = MockRecipeAPIService(session: mockSession, url: dummyRecipeUrl)
        let vm = RecipeListVM(apiService: apiService)
        return (apiService, vm)
    }
}

