//
//  ImageLoader.swift
//  TakeHome
//
//  Created by Habibur Rahman on 9/2/25.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    let cacheService : DataCacheService

    init(cacheService: DataCacheService) {
        self.cacheService = cacheService
    }
    
    @MainActor
    func load(from urlPath: String) async {
        let data = await cacheService.getData(urlPath: urlPath)
        guard let data = data, let uiImage =  UIImage(data: data) else { return }
        self.image = uiImage
    }
}
