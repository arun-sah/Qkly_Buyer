//
//  TokenManager.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Alamofire
import Combine

/// Class That will manage the tokenRefresh is needed
public class TokenManager {
    
    private let cacheManager: CacheManager
    
    // private let msalManager: MSALManager = MSALManager.shared
    
    /// The current token
    private lazy var currentToken: String? = {
        guard let token = token else {return nil}
        return  "Bearer \(token.accessToken)"
    }()
    
    /// The auth header
    var authHeader: HTTPHeader? {
        guard let token = currentToken else { return nil }
        return HTTPHeader.authorization(token)
    }
    
    public var tokenString: String? {
        guard let token = token
        else {return nil}
        return token.accessToken
    }
    
    /// The current token
    public var token: Token? {
        return self.cacheManager.getObject(type: Token.self, forKey: FrameworkCacheKey.token)
    }
    
    /// The endpoint path of the token refresh API
    private let endPath: String
    
    public init(cacheManager: CacheManager, enpointPath: String = "auth/refresh-token") {
        self.endPath = enpointPath
        self.cacheManager = cacheManager
    }
    
    func hasValidToken(router: NetworkingRouter, isForced: Bool = false) -> AnyPublisher<NetworkingResult<Token>, Never> {
        if isForced {
            return validateOrRefreshToken(isForced: isForced)
        } else if router.needTokenValidation {
            return validateOrRefreshToken()
        } else {
            return Just(NetworkingResult(router: EraserRouter.none)).eraseToAnyPublisher()
        }
    }
    
    func validateOrRefreshToken(isForced: Bool = false) -> AnyPublisher<NetworkingResult<Token>, Never> {
        
        // check we have the token in cache
        guard let token = token else {
            return Just(NetworkingResult(success: false, error: .tokenValidationFailed, router: EraserRouter.none)).eraseToAnyPublisher()
        }
        
        // if forced then directly refresh token
        if isForced {
            return refreshToken(token)
        }
        
        //return success if everything is neat and tid
        return refreshToken(token)//Just(NetworkingResult(router: EraserRouter.none)).eraseToAnyPublisher()
    }
    
    
    private func refreshToken(_ token: Token) -> AnyPublisher<NetworkingResult<Token>, Never> {
        let userDefaultCacheManager = UserDefaultCacheManagerFactory.get()
        let userInfodata = userDefaultCacheManager.get(String.self, forKey: FrameworkCacheKey.userLocationDetailFromAPIJson)
        guard let userInfodata else {
            return Future<NetworkingResult<Token>, Never> { [weak self] promise in
                promise(.success(NetworkingResult(success: false, error: .tokenRefreshFailed(nil), statusCode:NetworkingError.unauthorized.code , router: EraserRouter.none)))
            }
            .eraseToAnyPublisher()
        }
        let usermanager = UserManagerFactory.get()
        let useriD =  "" //usermanager.currentUser?.profileID ?? ""
        let parameters: [String: Any] = ["token": token.refreshToken,
                                         "device": "iphone",
                                         "deviceMetaData": "iOS",
                                         "userInfo": "\(userInfodata)"
                                         
        ]
        
        return Future<NetworkingResult<Token>, Never> { [weak self] promise in
            guard let self = self else { return }
            AF.request("\(Config.default.serverURL.appendingPathComponent(self.endPath))?userId=\(useriD)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Config.default.httpHeaders(addingHeader: [self.authHeader]))
                .validate()
                .responseJSON(completionHandler: {(jsonResponse) in
                    Logger.shared.log(jsonResponse)
                    switch jsonResponse.result {
                    case .success(let value):
                        let result = self.parseAndSaveToken(jsonResponse, value: value)
                        promise(.success(result))
                    case .failure(let error):
                        
                        promise(.success(NetworkingResult(success: false, error: .tokenRefreshFailed(error), statusCode:NetworkingError.unauthorized.code , router: EraserRouter.none)))
                    }
                })
        }
        .eraseToAnyPublisher()
    }
    
    
    private func parseAndSaveToken(_ response: AFDataResponse<Any>, value: Any) -> NetworkingResult<Token> {
        
        //get the token either from header or body
        if response.response?.statusCode != 200 {
            return NetworkingResult(success: false, error: .tokenRefreshFailed(nil),statusCode: NetworkingError.unauthorized.code, router: EraserRouter.none)
        }
        let json = extractTokenFromValue(value: value)
        guard let tokenJSON = json else {
            return NetworkingResult(success: false, error: .tokenRefreshFailed(nil),statusCode: NetworkingError.unauthorized.code, router: EraserRouter.none)
        }
        
        // try to get the token object
        do {
            let tokenData = try JSONSerialization.data(withJSONObject: tokenJSON, options: .prettyPrinted)
            let tokenObject = try JSONDecoder().decode(Token.self, from: tokenData)
            let saved = cacheManager.saveObject(type: Token.self, object: tokenObject, key: FrameworkCacheKey.token)
            return NetworkingResult(success: saved, error: .tokenRefreshFailed(nil),statusCode: 200, router: EraserRouter.none)
        } catch {
            return NetworkingResult(success: false, error: .tokenRefreshFailed(error),statusCode: NetworkingError.unauthorized.code, router: EraserRouter.none)
        }
    }
    
    private func extractTokenFromValue(value: Any) -> [String: Any]? {
        guard let data = value as? [String: Any] else { return nil }
        guard let json = data["data"] as? [[String: Any]]else { return nil }
        guard let jsonFirstelement = json.first else {return nil}
        return getValuesFromJSON(jsonFirstelement)
    }
    
    private func getValuesFromJSON(_ json: [AnyHashable: Any]) -> [String: Any]? {
        //we are looking for three keys for token, all three must be present for valid refresh
        guard let accessToken = json[Token.CodingKeys.accessToken.rawValue],
              let refreshToken = json[Token.CodingKeys.refreshToken.rawValue],
              let expiresIn = json[Token.CodingKeys.expiresIn.rawValue] else { return nil }
        
        //now we build the parseable JSON object
        let tokenJSON: [String: Any] = [Token.CodingKeys.accessToken.rawValue: accessToken,
                                        Token.CodingKeys.refreshToken.rawValue: refreshToken,
                                        Token.CodingKeys.expiresIn.rawValue: expiresIn]
        
        return  tokenJSON
    }
    
}
