//
//  DataCacheTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 4/2/25.
//

@testable import TakeHome
import XCTest

final class DataCacheTests: XCTestCase {
  
    var cache: DataCache!
  
    override func setUp() {
        super.setUp()
        cache = DataCache()
        cache.clearCache()
    }

    override func tearDown() {
        cache.clearCache()
        super.tearDown()
    }

    func test_GetData_WillNotFindDataIfDataIsNotCached() {
       
        let cachedImage = cache.getData(key: greenImageDataKey)
        
        XCTAssertNil(cachedImage)
    }

    func test_SetAndGetData_SetAndGetCachedDataSuccessfully() {
       
        cache.setData(data: greenImageData, key: greenImageDataKey)
        let cachedImage = cache.getData(key: greenImageDataKey)

        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(cachedImage, greenImageData)
    }

    func test_SetData_WillNotOverridePreviouslyStoredData() {

        cache.setData(data: greenImageData, key: greenImageDataKey)
        cache.setData(data: redImageData, key: greenImageDataKey)
        let cachedData = cache.getData(key: greenImageDataKey)

        XCTAssertNotNil(cachedData)
        XCTAssertEqual(greenImageData, cachedData)

        XCTAssertNotEqual(redImageData, cachedData)
    }

    func test_RemoveData_WillRemoveSingleCache() {

        cache.setData(data: greenImageData, key: greenImageDataKey)
        cache.removeData(forKey: greenImageDataKey)
        let cachedImage = cache.getData(key: greenImageDataKey)

        XCTAssertNil(cachedImage)
    }

    func test_RemoveAllImageCache() {

        cache.setData(data: greenImageData, key: greenImageDataKey)
        cache.setData(data: redImageData, key: redImageDataKey)
        cache.clearCache()

        let cachedGreenImage = cache.getData(key: greenImageDataKey)
        let cachedRedImage = cache.getData(key: redImageDataKey)

        XCTAssertNil(cachedGreenImage)
        XCTAssertNil(cachedRedImage)
    }
}
