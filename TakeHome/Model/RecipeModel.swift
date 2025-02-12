//
//  RecipeModel.swift
//  TakeHome
//
//  Created by Habibur Rahman on 29/1/25.
//

import Foundation


struct RecipeListRequestModel: Codable {
    let recipes: [Recipe]
}


struct Recipe: Codable, Identifiable {
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String
    let sourceURL: String?
    let id: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case id = "uuid"
        case youtubeURL = "youtube_url"
    }
}
