//
//  DataCacheService.swift
//  TakeHome
//
//  Created by Habibur Rahman on 4/2/25.
//

import SwiftUICore

class DataCacheService {
   
    let dataCache : DataCache
    let dataDownloader: DataDownloader

    init(dataCache : DataCache, dataDownloader: DataDownloader) {
        self.dataDownloader = dataDownloader
        self.dataCache = dataCache
    }

    func getData(urlPath: String) async -> Data? {
        if let cachedData = dataCache.getData(key: urlPath) {
            return cachedData
        }

        guard let downloadUrl = URL(string: urlPath) else { return nil }
        do {
            let downloadedData = try await dataDownloader.downloadData(from: downloadUrl)
            dataCache.setData(data: downloadedData, key: urlPath)

            return downloadedData
        } catch {
            return nil
        }
    }
}
