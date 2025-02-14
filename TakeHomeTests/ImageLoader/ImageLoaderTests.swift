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
        let (imageLoader, cacheService) = makeSUT()
        cacheService.stubCacheData(data: greenImageData, key: greenImageDataKey)
        let exp = expectation(description: "waiting for completion")

        let _ = await imageLoader.load(from: greenImageDataKey)
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)

        XCTAssertNotNil(imageLoader.image)
    }

    func test_load_FailedLoadImageFromInValidCachedData() async {
        let (imageLoader, cacheService) = makeSUT()
        let invalidImageData = Data()
        let key = "invalidKey"
        cacheService.stubCacheData(data: invalidImageData, key: key)
        let exp = expectation(description: "waiting for completion")

        let _ = await imageLoader.load(from: key)
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)

        XCTAssertNil(imageLoader.image)
    }

    // Helpers
    func makeSUT() -> (imageLoader: ImageLoader, cacheService: MockDataCacheService) {
        let downloader = MockDataDownloader(urlSession: mockSession)
        let cacheService = MockDataCacheService(dataCache: DataCache(), dataDownloader: downloader)
        let imageLoader = ImageLoader(cacheService: cacheService)
        return (imageLoader, cacheService)
    }
}
