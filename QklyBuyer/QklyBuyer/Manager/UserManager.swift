//
//  UserManager.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import Foundation
import Combine

enum SocialLoginType {
    case facebook
    case linkedin
    case apple
    case google
}

/// The manager for the User model
final public class UserManager {
    
    /// The cacheManager
     let cacheManager: CacheManager
    
    /// The cacheManager
    
    /// The instnace of networking that will help in API requests
    private let networking: Networking
    
    /// The result returned form networking
    let networkingResult = PassthroughSubject<NetworkingResult<SignUpModel>, Never>()
    /// The result returned form networking
    let networkingResultCurrentUserProfile    = PassthroughSubject<NetworkingResult<UserProfileResponse>, Never>()
    let networkingResultCurrentUserDetails    = PassthroughSubject<NetworkingResult<CurrentUserDetailsResponse>, Never>()
    
    let networkingResultLogin                = PassthroughSubject<NetworkingResult<[LoginAccessToken]>, Never>()
    let networkingResultSocialLogin                = PassthroughSubject<NetworkingResult<SocialLoginResponse>, Never>()
   
    /// Initializer
    init(networking: Networking) {
        self.networking = networking
        self.cacheManager = UserDefaultCacheManagerFactory.get()
    }
    
   
    
    func hasTokken() -> Bool {
        return  (cacheManager.getObject(type: Token.self, forKey: FrameworkCacheKey.token) != nil)
    }
    
   
    /// make network request
    /// - Parameter router: router
    func request(router: NetworkingRouter) {
        networking.requestObject(type: SignUpModel.self, router: router, completion: { [weak self] response in
            guard let self = self else { return }
            self.networkingResult.send(response)
        })
    }
    
//    func requestCurrentUserProfile(id: String) {
//        networking.requestObject(type: UserProfileResponse.self, router: ProfileRouter.selfProfile(id)) {[weak self] result in
//            guard let self = self else {return}
//            self.networkingResultCurrentUserProfile.send(result)
//        }
//    }
//
 
 
}
