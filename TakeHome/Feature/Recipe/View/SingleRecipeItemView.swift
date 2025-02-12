//
//  SingleRecipeItemView.swift
//  TakeHome
//
//  Created by Habibur Rahman on 9/2/25.
//

import SwiftUI

struct SingleRecipeItemView: View {
    @StateObject private var imageLoader: ImageLoader
    let recipe: Recipe
    

    init(imageLoader: ImageLoader, recipe: Recipe) {
        _imageLoader = StateObject(wrappedValue: imageLoader)
        self.recipe = recipe
    }

    var body: some View {
        HStack {
            Group {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .cornerRadius(5)
                } else {
                    ProgressView()
                        .frame(width: 70, height: 70)
                }
            }
            .onAppear {
                Task{
                    await imageLoader.load(from: recipe.photoURLSmall)
                }
               
            }
            .padding(.trailing, 10)
            VStack {
                Text(recipe.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(recipe.cuisine).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    SingleRecipeItemView(imageLoader: ImageLoader(cacheService: AppDependencies().cacheService), recipe: Recipe(cuisine: "Asia", name: "Thai Soup", photoURLLarge: "", photoURLSmall: "", sourceURL: "", id: "soup Id 1", youtubeURL: ""))
}
