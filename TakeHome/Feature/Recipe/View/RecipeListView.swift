//
//  RecipeListView.swift
//  TakeHome
//
//  Created by Habibur Rahman on 29/1/25.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var dependencies: AppDependencies
    @StateObject var vm: RecipeListVM

    init(recipeApiService: RecipeAPIService) {
        _vm = StateObject(wrappedValue: RecipeListVM(apiService: recipeApiService))
    }

    var body: some View {
        NavigationStack {
            VStack {
                if vm.errorMessage != nil {
                    Text(vm.errorMessage!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    List(vm.recipeList) { item in
                        SingleRecipeItemView(imageLoader: ImageLoader(cacheService: dependencies.cacheService), recipe: item)
                    }.listStyle(.automatic)
                        .listRowSpacing(20)
                }
                
                Spacer()
            }.onAppear{
                Task{
                    await vm.getRecipes()
                }
            }

            .navigationTitle("Recipe List")
        }
    }
}

#Preview {
    RecipeListView(recipeApiService: RecipeAPIService(session: URLSession(configuration: .ephemeral), url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!))
        .environmentObject(AppDependencies())
}
