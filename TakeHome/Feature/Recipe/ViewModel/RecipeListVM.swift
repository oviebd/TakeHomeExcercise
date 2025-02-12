//
//  RecipeListVM.swift
//  TakeHome
//
//  Created by Habibur Rahman on 29/1/25.
//

import Foundation


class RecipeListVM: ObservableObject {
    
    @Published var recipeList: [Recipe] = []
    let apiService : RecipeAPIService
    
    @Published var errorMessage : String?

    init(apiService : RecipeAPIService) {
        self.apiService = apiService
        getRecipes()
    }

    func getRecipes() {
        Task{
           let result = await apiService.getRecipes()
            DispatchQueue.main.async { [weak self] in
                self?.recipeList = result.data ?? []
                self?.errorMessage = result.data?.count ?? 0 <= 0 ? "Recipe List Empty!" : nil
            }
            
        }
    }
}
