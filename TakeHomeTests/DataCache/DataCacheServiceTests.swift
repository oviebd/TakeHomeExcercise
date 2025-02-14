//
//  DataCacheServiceTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 10/2/25.
//

@testable import TakeHome
import XCTest

final class DataCacheServiceTests: XCTestCase {
   
    let key = "http://example.com"
    let data = Data()
   
   
    func test_GetData_SuccessWhenCacheIsNilAndDataDownloadSucceed() async {

        let (cacheService,downloader) = makeSUT()
        downloader.stubDownloadData(from: URL(string: key)!, data: data, error: nil)
        let exp = expectation(description: "waiting for completion")
        
        XCTAssertNil(cacheService.dataCache.getData(key: key))
        
        let result = await cacheService.getData(urlPath: key)
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        
        XCTAssertEqual(result, data)
    }
    
    func test_GetData_FailedWhenCacheIsNilAndDataDownloadFailed() async {

        let (cacheService,downloader) = makeSUT()
        downloader.stubDownloadData(from: URL(string: key)!, data: data, error: error)
        let exp = expectation(description: "waiting for completion")
        
        XCTAssertNil(cacheService.dataCache.getData(key: key))
      
        let result = await cacheService.getData(urlPath: key)
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        XCTAssertNil(result)
    }
    
    func test_GetData_SuccessWhenDataAlreadyCached() async {
        
        let (cacheService,_) = makeSUT()
        let exp = expectation(description: "waiting for completion")
        cacheService.stubCacheData(data: data, key: key)
      
        let result = await cacheService.getData(urlPath: key)
        exp.fulfill()
        await fulfillment(of: [exp], timeout: 1.0)
        XCTAssertEqual(result, data)
       
    }
    
    //Helpers
    func makeSUT() -> (cacheService : MockDataCacheService, mockDownloader : MockDataDownloader) {
        
        let dataCache = DataCache()
        let mockDownloader = MockDataDownloader(urlSession: mockSession)
        let mockCacheService = MockDataCacheService(dataCache: dataCache, dataDownloader: mockDownloader)
        
        return (mockCacheService, mockDownloader)
    }
}

class MockDataCacheService: DataCacheService {
    
    func stubCacheData(data: Data, key: String) {
        dataCache.setData(data: data, key: key)
    }
}
