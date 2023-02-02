//
//  CreateAccountViewModel.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/30/23.
//

import Foundation
import Combine

class CreateAccountViewModel: BaseViewModel {
    
    enum RegistrationResult {
        case serverError
        case success
        case needsEmailVerification
        case duplicateUser
        case needsFacebookEmail
    }
    
    typealias RegistrationResultObserverValue = (RegistrationResult, String?)
    
    let userManager: UserManager?
    
    let userDefaultCacheManager = UserDefaultCacheManagerFactory.get()
    
    init(userManager: UserManager) {
        self.userManager = userManager
        super.init()
        observeValidation()
        observeNetworkCalls()
    }
    
    //Request variables
    @Published var fullName: String?
    @Published var firstname: String?
    @Published var lastname: String?
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    @Published var country: Country?
    
    var fullnameValidationState         = CurrentValueSubject<(Bool, String), Never>((false, ""))
    var emailValidationState            = CurrentValueSubject<(Bool, String), Never>((false, ""))
    var countryValidationState          = CurrentValueSubject<(Bool, String), Never>((false, ""))
    var passwordValidationState         = CurrentValueSubject<(Bool, String), Never>((false, ""))
    var confirmPasswordValidationState  = CurrentValueSubject<(Bool, String), Never>((false, ""))
    var agreedToTermsAndConditions      = false
    
    var isInputValid: Bool {
        fullnameValidationState.value.0 && emailValidationState.value.0 && countryValidationState.value.0 && passwordValidationState.value.0 && confirmPasswordValidationState.value.0 && agreedToTermsAndConditions
    }
    ///Error: Bool, message: String
    var registrationResultObserver = PassthroughSubject<RegistrationResultObserverValue, Never>()
    
    func observeValidation() {
        
        $fullName.sink {[weak self] value in
            guard let self else { return }
            let splitName = self.splitFullName(fullname: value ?? "")
            self.firstname = splitName.0
            self.lastname  = splitName.1
            self.fullnameValidationState.value = self.isFullnameValid(firstname: splitName.0, lastname: splitName.1)
        }.store(in: &bag)
        
        $email.sink {[weak self] value in
            guard let self else { return }
            self.emailValidationState.value = self.isEmailValid(string: value ?? "")
        }.store(in: &bag)
        
        $country.sink {[weak self] value in
            guard let self else { return }
            self.countryValidationState.value = self.isCountryValid(country: value)
        }.store(in: &bag)
        
        $password.sink {[weak self] value in
            guard let self else { return }
            self.passwordValidationState.value = self.isPasswordValid(string: value ?? "")
        }.store(in: &bag)
        
        $confirmPassword.sink {[weak self] value in
            guard let self else { return }
            self.confirmPasswordValidationState.value = self.isConfirmPasswordValid(string: value ?? "", password: self.password ?? "")
        }.store(in: &bag)
        
    }
    
    func validateAndSendRequest() -> Bool{
        guard isInputValid else {return false}
        processSignUp()
        return true
    }
    
    //MARK:- Network call observers
    
    func observeNetworkCalls() {
        
        userManager!.networkingResult.receive(on: RunLoop.main).sink { [weak self] response in
            guard let self = self else { return }
                switch response.router {
                case AuthRouter.register:
                        if response.statusCode == 200 {
                            if response.result?.duplicateUser ?? false{
                                self.registrationResultObserver.send((.duplicateUser, "User with same email address already exists, Please use different email to sign up."))
                                return
                            }
                            if response.result?.isSuccess ?? false{
                                self.registrationResultObserver.send((.success, ""))
                                return
                            }else {
                                self.registrationResultObserver.send((.serverError, "Server Error with status code: \(response.statusCode)"))
                            }
                        } else {
                            self.registrationResultObserver.send((.serverError, "Server Error with status code: \(response.statusCode)"))
                        }
                default:
                    break
                }
        }.store(in: &bag)
        
        userManager?.networkingResultSocialLogin.sink(receiveValue: { [weak self] result in
            guard let self = self else {return}
            if let result = result.result {
                let token = Token(result: result)
                self.userManager?.cacheManager.saveObject(type: Token.self, object: token, key: FrameworkCacheKey.token)
                let needsFBEmailUpdate = !result.hasEmail
                self.userManager?.cacheManager.set(Bool.self, value: needsFBEmailUpdate, key: FrameworkCacheKey.needsEmailUpdateFB)
                self.retrieveCurrentUserDetails()
            }else{
                self.registrationResultObserver.send((RegistrationResult.serverError, result.message))
            }
        }).store(in: &bag)
        
        userManager?.networkingResultCurrentUserDetails.sink(receiveValue: { [weak self] result in
            guard let self else {return}
            if let model = result.result {
                if model.isEmailVerified ?? false {
                    //_ = self.userManager.setUser(user: model)
                    self.userManager?.cacheManager.set(Bool.self, value: false, key: FrameworkCacheKey.isGuestLogin)
                    self.userManager?.cacheManager.set(Bool.self, value: true, key: FrameworkCacheKey.isLoginSignUpDone)
                    self.registerDevice()
                }
                
                let needsEmailUpdate = self.userManager?.cacheManager.get(Bool.self, forKey: FrameworkCacheKey.needsEmailUpdateFB)
                
                if needsEmailUpdate == true {
                    self.trigger.send(AuthRoute.facebookEmailUpdate)
                }else{
                    self.trigger.send(AuthRoute.finish)
                }
            } else {
                _ = self.userManager?.cacheManager.delete(forKey: FrameworkCacheKey.token)
                self.registrationResultObserver.send((.needsEmailVerification, "We have send you a verification email.\n if you don't recive an email please click resend."))
            }
        }).store(in: &bag)
        
    }
    
    //MARK:- API Calls
    
    func processSignUp() {
        let parameters: Parameters = [
            "firstName": firstname,
            "lastName": lastname,
            "email": email,
            "country": country,
            "password": password,
            "ConfirmPassword": confirmPassword,
            "profileType": 1,
            
        ]
        userManager!.request(router: AuthRouter.register(parameters))
    }
    
    func loginWithGoogle(idToken: String) {
        let parameters: Parameters = [
            "idToken": idToken,
            "refreshTokenRequestModel": [
                    "device": "iphone",
                    "deviceMetaData": "iOS"
                ]
            ]
        //userManager?.requestLogin(ssoMethod: .google, parameters: parameters)
    }
    
    func loginWithLinkedIn(code: String) {

        let params: Parameters = [
            "accessToken" : code,
            "refreshTokenRequestModel": [
                    "device": "iphone",
                    "deviceMetaData": "iOS"
                ]
               ]
        
        //userManager?.requestLogin(ssoMethod: .linkedin, parameters: params)
    }
    
    func registerDevice() {
        
    }
    
    func retrieveCurrentUserDetails() {
        //userManager?.requestCurrentUserDetails()
    }
    
    //INPUT FIELD VALIDATION RULES
    
    func isFullnameValid(firstname: String, lastname: String) -> (Bool, String) {
        let valid = firstname != "" && lastname != ""
        let message: String = {
            if firstname == "" {
                return "Full name should not be empty"
            }
            if lastname == "" {
                return "Last name is required"
            }
            return ""
        }()
        return (valid, message)
    }
    
    func isEmailValid(string: String) -> (Bool, String) {
        let valid = string != "" && string.validateEmail()
        let message: String = {
            if string == "" {
                return "Email should not be empty"
            }
            if !string.validateEmail() {
                return "Please enter a valid email"
            }
            return ""
        }()
        return (valid, message)
    }
    
    func isCountryValid(country: Country?) -> (Bool, String) {
        let valid = country != nil
        let message: String = {
            if country == nil {
                return "Please select a country"
            }
            return ""
        }()
        return (valid, message)
    }
    
    func isPasswordValid(string: String) -> (Bool, String) {
        let valid = string != "" && string.validatePassword()
        let message: String = {
            if string == "" {
                return "Password should not be empty"
            }
            if !string.validatePassword() {
                return "Password must have minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character"
            }
            return ""
        }()
        return (valid, message)
    }
    
    func isConfirmPasswordValid(string: String, password: String) -> (Bool, String) {
        let valid = string == password
        let message: String = {
            if !valid {
                return "Password mismatch"
            }
            return ""
        }()
        return (valid, message)
    }
    
    //Utility
    
    func splitFullName(fullname: String) -> (String, String){
        var components = fullname.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            let lastName  = components.joined(separator: " ")
            return (firstName, lastName)
        }
        return ("","")
    }
    
}
