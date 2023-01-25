//
//  RequestSynchronizer.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Alamofire
import Combine

final class RequestSynchronizer<O>: OperationQueueable {
    
    /// Cancellable bag
    private var bag = Set<AnyCancellable>()
    
    /// The client for request
    private let client: Client
    
    /// The route of the request
    private let router: NetworkingRouter
    
    /// The token manager instnace
    private var tokenManager: TokenManager
    private var isuploadFile:Bool
    private var uploadDocumentFrom:UploadDocumentFrom
    private var parametersdata: [String: Data?]?
    private var params:[String:Any]?
    
    init(client: Client, router: NetworkingRouter, tokenManager: TokenManager,isuploadFile:Bool,uploadDocumentFrom:UploadDocumentFrom, parametersdata: [String: Data?]?, params: [String: Any]?) {
        self.router = router
        self.client = client
        self.tokenManager = tokenManager
        self.isuploadFile = isuploadFile
        self.uploadDocumentFrom = uploadDocumentFrom
        self.parametersdata = parametersdata
        self.params = params
        self.observeNetworkCondition()
    }
    
    /// The triggers that we received during various request stages
    var trigger = PassthroughSubject<SynchronizerState, Never>()
    
    /// Starts the synchronizer
    func start() {
        
        // suspend the queue while we check the state
        self.trigger.send(.suspendQueue)
        
        // check if we can reach the internet
        if !Connection.shared.isReachable {
            self.trigger.send(.terminate)
            self.trigger.send(.completed(NetworkingResult<O>(success: false, error: .noInternetConnection,statusCode: 1, router: router)))
        } else {
            self.continueWithResult (router: self.router, isuploadFile: isuploadFile, uploadDocumentFrom: uploadDocumentFrom,parametersdata: parametersdata,params:params)
//            self.validateTokenAndContinue(isuploadFile: isuploadFile,uploadDocumentFrom:uploadDocumentFrom, parametersdata: parametersdata ,params: params)
        }
    }
    
    /// This will suspend or start the queue operation when network connection is lost/found
    func observeNetworkCondition() {
        Connection.shared.connectionSate.sink { [weak self] state in
            guard let self = self else { return }
            if state == .notConnected {
                self.trigger.send(.terminate)
                self.trigger.send(.completed(NetworkingResult<O>(success: false, error: .noInternetConnection,statusCode: 1, router: self.router)))
            }
        }.store(in: &bag)
    }
    
    /// Method to perform token check, if it succeed we continue
    private func validateTokenAndContinue(forceValidate: Bool = false, isuploadFile:Bool,uploadDocumentFrom:UploadDocumentFrom, parametersdata: [String: Data?]?, params: [String: Any]?) {
        tokenManager.hasValidToken(router: router, isForced: forceValidate).sink { [weak self](result) in
            guard let self = self else { return }
            if result.statusCode == NetworkingError.unauthorized.code {
                self.trigger.send(.terminate)
                self.trigger.send(.completed(NetworkingResult<O>(success: false, error: .noInternetConnection,statusCode: 1, router: self.router)))
              //  NotificationCenter.default.post(name:Constant.NotificationName.unauthorized.notificationName, object: nil)
              
            }
            self.continueWithResult( router: self.router, isuploadFile: isuploadFile, uploadDocumentFrom: uploadDocumentFrom,parametersdata: parametersdata,params:params)
        }.store(in: &bag)
    }
    
    /// This method will check the result from token refresh and start the queue
    /// - Parameter result: the refreshToken API call result
    /// - Parameter router: the router
    private func continueWithResult(router: NetworkingRouter, isuploadFile: Bool,uploadDocumentFrom:UploadDocumentFrom, parametersdata: [String: Data?]?, params: [String: Any]?) {
        
        // resume the queue to start the operation
        self.trigger.send(.resumeQueue)
        
        // start processing
       
            self.client.performRequest(type: O.self, router: router, isuploadFile: isuploadFile, parametersdata: parametersdata, params: params, uploadDocumentFrom: uploadDocumentFrom).sink { [weak self] (result) in
                guard let self = self else { return }
                
                // if we receive 401 error while perform request then we need to force refresh token
                if result.statusCode == NetworkingError.unauthorized.code && router.needTokenValidation {
                    self.validateTokenAndContinue(forceValidate: false, isuploadFile: isuploadFile, uploadDocumentFrom: uploadDocumentFrom,parametersdata: parametersdata,params: params)
                    return
                }
                self.trigger.send(.completed(result))
            }.store(in: &bag)
        
    }
}

