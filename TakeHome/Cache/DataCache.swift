//
//  DataCache.swift
//  TakeHome
//
//  Created by Habibur Rahman on 3/2/25.
//

import Foundation

class DataCache {
   // static let shared = DataCache()
    let cache = NSCache<AnyObject, AnyObject>()

    init() {
        cache.countLimit = 100 // Limit number of images in cache
        cache.totalCostLimit = 50 * 1024 * 1024 // Limit cache size to 50MB
    }

    func setData(data: Data, key: String) {
        let imageFromCache = getData(key: key)
        if imageFromCache == nil {
            cache.setObject(data as NSData, forKey: key as NSString)
        }
    }

    func getData(key: String) -> Data? {
        if let imageFromCache = cache.object(forKey: key as NSString) as? Data {
            return imageFromCache
        }

        return nil
    }

    func removeData(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }

    func clearCache() {
        cache.removeAllObjects()
    }
}
