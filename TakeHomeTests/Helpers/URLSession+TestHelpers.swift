//
//  HTTPURLResponse+TestHelpers.swift
//  TakeHomeTests
//
//  Created by Habibur Rahman on 4/2/25.
//

import Foundation

var mockSession: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
}()


func getSuccessResponse(with url: URL) -> HTTPURLResponse {
    return HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!
}
