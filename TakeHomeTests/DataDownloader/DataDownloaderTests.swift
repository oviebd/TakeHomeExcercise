//
//  ImageDownloaderTests.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 4/2/25.
//

@testable import TakeHome
import XCTest

final class DataDownloaderTests: XCTestCase {
   
    let greenImageUrl = URL(string: greenImageDataKey)!
    

    func test_DownloadData_SuccessWithData() async {

        let downloader = makeSUT()
        downloader.stubDownloadData(from: greenImageUrl, data: greenImageData, error: nil)
        do {
            let fetchedData = try await downloader.downloadData(from: greenImageUrl)
            XCTAssertNotNil(fetchedData)
            XCTAssertEqual(fetchedData, greenImageData)
        } catch {
            XCTFail("Expected Success instead get \(error)")
        }
    }
    
    func test_DownloadData_FailedWithError() async {

        let downloader = makeSUT()
        downloader.stubDownloadData(from: greenImageUrl, data: greenImageData, error: error)
        do {
            let fetchedData = try await downloader.downloadData(from: greenImageUrl)
            XCTAssertNil(fetchedData)
        } catch (let fetchedError) {
            
            XCTAssertEqual(error.domain, (fetchedError as NSError).domain)
            XCTAssertEqual(error.code, (fetchedError as NSError).code)
        }
    }
    
    func makeSUT() -> MockDataDownloader{
        return  MockDataDownloader(urlSession: mockSession)
    }
}


