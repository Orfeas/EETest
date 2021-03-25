//
//  APIDeserializer.swift
//  SafeToNet
//
//  Created by Orfeas Iliopoulos on 12/3/21.
//

import Foundation

class APIDeserializer<T: Decodable> {
    static var decoder: JSONDecoder {

        let lazyDecoder = JSONDecoder()
        lazyDecoder.keyDecodingStrategy = .convertFromSnakeCase

        return lazyDecoder
    }

    class func getDataModelFromResponse<T: Decodable, U>(response: U) -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            let dataModel = try decoder.decode(T.self, from: data)
            return dataModel
        } catch {
            return nil
        }
    }
}
