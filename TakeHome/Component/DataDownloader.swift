//
//  DataDownloader.swift
//  TakeHome
//
//  Created by Habibur Rahman on 4/2/25.
//

import Foundation

class DataDownloader {
    let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func downloadData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await urlSession.data(from: url)
            return data

        } catch {
            throw error
        }
    }
}
