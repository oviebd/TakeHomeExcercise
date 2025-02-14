//
//  MockRecipeAPIService.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 13/2/25.
//


@testable import TakeHome
import XCTest

class MockRecipeAPIService : RecipeAPIService {
    
    func stub(response: HTTPURLResponse?, data: Data?, error: Error?){
        MockURLProtocol.stubRequest(response: response, data: data, error: error)
    }
}
