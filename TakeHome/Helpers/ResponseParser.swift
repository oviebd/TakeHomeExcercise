//
//  ResponseParser.swift
//  TakeHome
//
//  Created by Habibur Rahman on 29/1/25.
//

import Foundation
final class ResponseParser {

    func parseResponse<T: Codable>(from data: Data) throws -> T {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        }
        catch let DecodingError.keyNotFound(key, context) {
            print("Decoding error (keyNotFound): \(key) not found in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.dataCorrupted(context) {
            print("Decoding error (dataCorrupted): data corrupted in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Decoding error (typeMismatch): type mismatch of \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.typeMismatch(type, context)
        } catch let DecodingError.valueNotFound(type, context) {
            print("Decoding error (valueNotFound): value not found for \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.valueNotFound(type, context)
        }
    }
}
