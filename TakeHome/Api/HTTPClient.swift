//
//  HTTPClient.swift
//  TakeHome
//
//  Created by Habibur Rahman on 29/1/25.
//

import Foundation


public protocol HTTPClient {
    typealias Result = Swift.Result<(data : Data, urlResponse : HTTPURLResponse),Error>
    //@discardableResult
    func getAPIResponse(from url: URL) async -> HTTPClient.Result
}


