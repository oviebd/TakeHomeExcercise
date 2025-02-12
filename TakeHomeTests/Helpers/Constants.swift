//
//  Constants.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 11/2/25.
//

import Foundation
@testable import TakeHome
import UIKit

let greenImageDataKey = "https://green.com"
let greenImageData = UIImage.make(withColor: .green).pngData()!
let redImageData = UIImage.make(withColor: .red).pngData()!
let redImageDataKey = "https://redImage.com"

let error = NSError(domain: "Error", code: 0)

var dummyRecipeUrl = URL(string: "https//www.aUrl.com")!
func singleDummyRecipe01() -> Recipe {
    return Recipe(cuisine: "Malaysian", name: "Apam Balik", photoURLLarge: "A url", photoURLSmall: "small url", sourceURL: "source", id: "uuid1", youtubeURL: "youtube url")
}

func validRecipeListJsonWithSingleRecipe() -> String {
    let jsonString = """
    {
        "recipes": [
            {
                "cuisine": "British",
                "name": "Bakewell Tart",
                "photo_url_large": "https://some.url/large.jpg",
                "photo_url_small": "https://some.url/small.jpg",
                "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                "source_url": "https://some.url/index.html",
                "youtube_url": "https://www.youtube.com/watch?v=some.id"
            }
        ]
    }
    """

    return jsonString
}

func validRecipeListJsonWithEmptyList() -> String {
    let jsonString = """
    {
        "recipes": [
        ]
    }
    """

    return jsonString
}

func malformedRecipeListJsonWithSingleRecipe() -> String {
    let jsonString = """
    {
        "recipes": [
            {
                "cuisine": "Malaysian",
                     "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                     "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                     "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                     "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                     "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
        ]
    }
    """

    return jsonString
}
