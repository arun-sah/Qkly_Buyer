//
//  ForgotPasswordViewModel.swift
//  Qkly
//
//  Created by Arun Sah on 16/03/2022.
//


import Foundation
import Combine
import Alamofire

class ForgotPasswordViewModel: BaseViewModel {
    
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
        super.init()
    }
    
    var email: String = ""
    
//    func isValid() -> (Bool, String) {
//        let message = invalidCredentialMessage()
//        return (message == nil, message ?? "")
//    }
    
//    func observeLogin(completion: @escaping(_ statusCode: Int, _ message: String)->()) {
//        userManager.networkingResultLogin.sink {result in
//        }.store(in: &bag)
//    }
//
//    private func invalidCredentialMessage() -> String? {
//        if !email.validateEmail(){
//            return "Please enter a valid email."
//        }
//        return nil
//    }
//
//    func sendForgotPasswordRequest() {
//        userManager.requestForgotPassword(params: email)
//    }
    
}
