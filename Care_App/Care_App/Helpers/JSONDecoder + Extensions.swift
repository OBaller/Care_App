//
//  JSONDecoder + Extensions.swift
//  Care_App
//
//  Created by Naseem Oyebola on 19/06/2024.
//

import Foundation

extension KeyedDecodingContainer {
  func decodeFlexible<T>(_ type: T.Type, forKey key: K) throws -> T where T: LosslessStringConvertible & Decodable {
    // Try decoding as the specified type directly
    if let value = try? decode(T.self, forKey: key) {
      return value
    }
    // Try decoding as a String and then convert to the specified type
    if let stringValue = try? decode(String.self, forKey: key),
       let value = T(stringValue) {
      return value
    }
    throw DecodingError.typeMismatch(T.self, DecodingError.Context(
      codingPath: [key],
      debugDescription: "Expected to decode \(T.self) but found a different type instead."
    ))
  }
}
