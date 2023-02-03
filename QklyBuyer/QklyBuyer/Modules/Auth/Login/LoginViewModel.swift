//
//  LoginViewModel.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 2/2/23.
//

import Combine
import LocalAuthentication

class LoginViewModel: BaseViewModel {
    
    override init() {
        super.init()
        observeValidation()
    }
    
    var emailValidationState            = CurrentValueSubject<(Bool, String), Never>((false, ""))
    var passwordValidationState         = CurrentValueSubject<(Bool, String), Never>((false, ""))
    
    @Published var email: String?
    @Published var password: String?
    
    var biometricType: LABiometryType = {
        let context = LAContext()
        let available = try? context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
        return context.biometryType
    }()
    
    private func observeValidation() {
        $email.sink {[weak self] value in
            guard let self else { return }
            self.emailValidationState.value = self.isEmailValid(string: value ?? "")
        }.store(in: &bag)
        
        $password.sink {[weak self] value in
            guard let self else { return }
            self.passwordValidationState.value = self.isPasswordValid(string: value ?? "")
        }.store(in: &bag)
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
    
    func isPasswordValid(string: String) -> (Bool, String) {
        let valid = string != "" && string.validatePassword()
        let message: String = {
            if string == "" {
                return "Password should not be empty"
            }
            if !string.validatePassword() {
                return "The password is not valid"
            }
            return ""
        }()
        return (valid, message)
    }
    
}
