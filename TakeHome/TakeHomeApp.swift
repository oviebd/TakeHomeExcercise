//
//  TakeHomeApp.swift
//  TakeHome
//
//  Created by Habibur Rahman on 28/1/25.
//

import SwiftUI

class AppDependencies: ObservableObject {
   
    let dataCache : DataCache
    let urlSession: URLSession
    let recipeApiService: RecipeAPIService
    let dataDownloader : DataDownloader
    let cacheService : DataCacheService

    init() {
        dataCache = DataCache()
        urlSession = URLSession(configuration: .ephemeral)
        recipeApiService = RecipeAPIService(session: urlSession,
                                         url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!)
        dataDownloader = DataDownloader(urlSession: urlSession)
        cacheService = DataCacheService(dataCache: dataCache, dataDownloader: dataDownloader)
    }
}

@main
struct TakeHomeApp: App {
    @StateObject private var dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            RecipeListView(recipeApiService: dependencies.recipeApiService)
                .environmentObject(dependencies)
        }
    }
}
