//
//  ResultBuilder.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Combine

/// The builder Info from the response
struct BuilderInfo {
    let title: String
    let message: String
    let isArray: Bool
    let data: Data?
    var tokenInfo: Any?
       //  let pagination: Pagination?
}

public struct ResultBuilder {
    
    //public initializer
    public init() {}
    
    /// Method to build the result form the builder info
    ///
    /// - Parameter info: the builder info
    /// - Returns: NetworkingResult of result
    /// - Throws: If there are any decoding errors
    func buildWithInfo<O>(type: O.Type, _ info: BuilderInfo, router: NetworkingRouter) throws -> NetworkingResult<O> {
        
//        /// process the token info if available
//        if let tokenData = info.tokenInfo {
//           // parseAndSaveToken(tokenData)
//        }
        
        //process the decodable
        if let decodableType = type as? Decodable.Type, let result = try? decodableType.init(data: info.data!) as? O {
            return NetworkingResult<O>(result: result, title: info.title, message: info.message, router: router)
        } else {
            if info.data != nil {
                return  NetworkingResult<O>(result: nil, title: info.title, message: info.message, router: router,data: info.data)
            } else {
                throw NetworkingError.nonParsableErrorReceived

            }
        }
    }
    
    /// Method to parse and save the token data
    ///
    /// - Parameter tokenData: the tokenData
    private func parseAndSaveToken(_ tokenData: Any) {
        do {
            let data = try JSONSerialization.data(withJSONObject: tokenData, options: .prettyPrinted)
            let token = try JSONDecoder().decode(Token.self, from: data)
            let cacheManager = UserDefaultCacheManagerFactory.get()
            cacheManager.saveObject(type: Token.self, object: token, key: FrameworkCacheKey.token)
        } catch {
            assertionFailure()
        }
    }
}
