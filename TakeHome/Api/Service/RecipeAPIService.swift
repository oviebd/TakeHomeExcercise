//
//  RecipeAPIService.swift
//  TakeHome
//
//  Created by Habibur Rahman on 29/1/25.
//

import Combine
import Foundation

class RecipeAPIService {
    public typealias SingleFetchResult = (data: [Recipe]?, error: Error?)

    let httpClient: HTTPClient
    let url: URL
   // let urlPath = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    init(session: URLSession, url : URL) {
        self.httpClient = URLSessionHTTPClient(session: session)
        self.url = url
    }

    func getRecipes() async -> SingleFetchResult {
        let result = await httpClient.getAPIResponse(from: url)

        switch result {
        case let .success(data):
            do {
                let recipieListModel: RecipeListRequestModel = try ResponseParser().parseResponse(from: data.data)

                return (recipieListModel.recipes, nil)

            } catch {
                return (nil, error)
            }
        case let .failure(error):
            return (nil, error)
        }
    }
}
