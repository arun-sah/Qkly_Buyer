//
//  Decodable.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//
import Foundation

public extension Decodable {
    init(data: Data) throws {
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            } else {
                print(error.localizedDescription)
            }
            throw error
        }
    }
}
