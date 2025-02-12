//
//  MockDataDownloader.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 11/2/25.
//

import Foundation
@testable import TakeHome

class MockDataDownloader : DataDownloader {
    
    func stubDownloadData(from url: URL, data : Data?, error: Error?) {
        let response = getSuccessResponse(with: url)
      
        MockURLProtocol.stubRequest(response: response, data: data, error: error)
    }
}
