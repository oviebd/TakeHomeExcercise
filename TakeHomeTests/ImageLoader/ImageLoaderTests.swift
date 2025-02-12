//
//  ImageLoaderTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 9/2/25.
//

@testable import TakeHome
import XCTest

final class ImageLoaderTests: XCTestCase {
    
    func test_load_ImageSuccessfullyLoadFromValidCachedImage() async {
        let (imageLoader,cacheService) = makeSUT()
        cacheService.stubCacheData(data: greenImageData, key: greenImageDataKey)
        
        let _ = await imageLoader.load(from: greenImageDataKey)
        
        XCTAssertNotNil(imageLoader.image)
    }
    
    func test_load_FailedLoadImageFromInValidCachedData() async {
        let (imageLoader,cacheService) = makeSUT()
        let invalidImageData = Data()
        let key = "invalidKey"
        cacheService.stubCacheData(data: invalidImageData , key: key)
        
        let _ = await imageLoader.load(from: key)
        
        XCTAssertNil(imageLoader.image)
    }
    
    //Helpers
    func makeSUT() -> (imageLoader : ImageLoader, cacheService : MockDataCacheService) {
        let downloader =  MockDataDownloader(urlSession: mockSession)
        let cacheService = MockDataCacheService(dataCache: DataCache(), dataDownloader: downloader)
        let imageLoader =  ImageLoader(cacheService: cacheService)
        return (imageLoader, cacheService)
    }
    
    

}
