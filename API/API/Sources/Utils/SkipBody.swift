//
//  APIClient.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

@propertyWrapper
struct SkipBody<T: Decodable> {
   var wrappedValue: T
}

extension SkipBody: Codable {
   init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      self.wrappedValue = try container.decode(T.self)
   }

   func encode(to encoder: Encoder) throws {}
}

// MARK: - KeyedEncodingContainer

extension KeyedEncodingContainer {
    mutating func encode<T: Decodable>(_ value: SkipBody<T>, forKey key: K) throws {
       // skip body
   }
}
