//
//  CreateAccountController.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/27/23.
//

import UIKit

class CreateAccountController: BaseController {
    
    //MARK:- NAVIGATION BAR OUTLETS
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navView: UIView!
    
    @IBOutlet weak var upperNavView: UIView!
    @IBOutlet weak var navImageView: UIImageView!
    
    @IBOutlet weak var navViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var createAccountMinorLabe: UILabel!
    
    @IBOutlet weak var agreeToTermsButton: CheckRoundButton!
    @IBOutlet weak var signupButton: FormActionButton!
    
    @IBOutlet weak var createAccountLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAcountBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    var originalHeightConstraint: CGFloat = 200.0
    var originalLeftConstraint: CGFloat = 20.0
    var originalBottomConstraint: CGFloat = 40.0
    
    private var lastContentOffset: CGFloat = 0
    
    //MARK:- FORM OUTLETS
    
    @IBOutlet weak var fullnameTextField: QBValidationTextField!
    @IBOutlet weak var emailTextField: QBValidationTextField!
    @IBOutlet weak var passwordTextField: QBValidationTextField!
    @IBOutlet weak var confirmPasswordTextField: QBValidationTextField!
    @IBOutlet weak var countryTextField: QBValidationTextField!
    
    //MARK:- Variables and objects
    
    var viewModel: CreateAccountViewModel = CreateAccountViewModel(userManager: UserManagerFactory.get())

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        scrollView.delegate = contentStackView.bounds.height > scrollView.bounds.height ? self : nil
        upperNavView.layer.opacity = 0
        
        setupFields()
        bindValues()
    }
    
    override func observeEvents() {
        
        viewModel.registrationResultObserver.receive(on: RunLoop.main).sink {[weak self] result in
            guard let self else {return}
            self.hideHUD()
            let resultEnum = result.0
            let message = result.1
            
            switch resultEnum {
            case .serverError:
                self.showAlert(title: "Error", msg: message ?? "Server error occurred.") { action in}
            case .success:
                self.showCongratulationsAlert()
            case .needsEmailVerification:
                //redirect to email controller
                break
            case .duplicateUser:
                self.showAlert(title: "Error", msg: message ?? "", completion: nil)
            case .needsFacebookEmail:
                //redirect to facebook
                break
            }
            
        }.store(in: &viewModel.bag)
        
        
        
    }
    
    func setupFields() {
        fullnameTextField.titlePlaceholder = "Full name"
        fullnameTextField.textFieldPlaceholder = "Enter your full name"
        emailTextField.titlePlaceholder = "Email"
        emailTextField.textFieldPlaceholder = "Enter your email"
        passwordTextField.titlePlaceholder = "Password"
        passwordTextField.textFieldPlaceholder = "Type password here"
        confirmPasswordTextField.titlePlaceholder = "Confirm Password"
        confirmPasswordTextField.textFieldPlaceholder = "Re-type password here"
        countryTextField.titlePlaceholder = "Country"
        countryTextField.textFieldPlaceholder = "Select"
        
        passwordTextField.textfield.isSecureTextEntry           = true
        confirmPasswordTextField.textfield.isSecureTextEntry    = true
        
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        countryTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func bindValues() {
        fullnameTextField.textfield.textPublisher.sink {[weak self] value in
            guard let self else {return}
            self.viewModel.fullName = value
        }.store(in: &viewModel.bag)
        
        emailTextField.textfield.textPublisher.sink {[weak self] value in
            guard let self else {return}
            self.viewModel.email = value
        }.store(in: &viewModel.bag)
        
        passwordTextField.textfield.textPublisher.sink {[weak self] value in
            guard let self else {return}
            self.viewModel.password = value
        }.store(in: &viewModel.bag)
        
        confirmPasswordTextField.textfield.textPublisher.sink {[weak self] value in
            guard let self else {return}
            self.viewModel.confirmPassword = value
        }.store(in: &viewModel.bag)
        
        agreeToTermsButton.$isChecked.sink { [weak self] value in
            guard let self else {return}
            self.viewModel.agreedToTermsAndConditions = value
        }.store(in: &viewModel.bag)
        
        signupButton.formButtonTapped.receive(on: RunLoop.main).sink {[weak self] _ in
            guard let self else {return}
            //self.validateForm()
            
            let controller = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginController")
            self.navigationController?.pushViewController(controller, animated: true)
        }.store(in: &viewModel.bag)
    }
    
    func validateTextField(textField: QBValidationTextField) -> Bool{
        var isValid = false
        var message = ""
        
        switch textField {
        case fullnameTextField:
            isValid = viewModel.fullnameValidationState.value.0
            message = viewModel.fullnameValidationState.value.1
            break
        case emailTextField:
            isValid = viewModel.emailValidationState.value.0
            message = viewModel.emailValidationState.value.1
            break
        case passwordTextField:
            isValid = viewModel.passwordValidationState.value.0
            message = viewModel.passwordValidationState.value.1
            break
        case confirmPasswordTextField:
            isValid = viewModel.confirmPasswordValidationState.value.0
            message = viewModel.confirmPasswordValidationState.value.1
            break
        case countryTextField:
            isValid = viewModel.countryValidationState.value.0
            message = viewModel.countryValidationState.value.1
        default:
            break
        }
        
        if !isValid {
            textField.setValidation(state: .invalid)
            textField.showValidationMessage(message: message)
        }else{
            textField.setValidation(state: .fresh)
        }
        
        return isValid
    }
    
    func showCongratulationsAlert() {
    }
    
    func validateForm() {
        
        if !validateTextField(textField: fullnameTextField) {
            scrollView.scrollRectToVisible(fullnameTextField.frame, animated: true)
            fullnameTextField.becomeFirstResponder()
            return
        }else if !validateTextField(textField: emailTextField) {
            scrollView.scrollRectToVisible(emailTextField.frame, animated: true)
            emailTextField.becomeFirstResponder()
            return
        }else if !validateTextField(textField: countryTextField) {
            scrollView.scrollRectToVisible(countryTextField.frame, animated: true)
            return
        }else if !validateTextField(textField: passwordTextField) {
            scrollView.scrollRectToVisible(passwordTextField.frame, animated: true)
            passwordTextField.becomeFirstResponder()
            return
        }else if !validateTextField(textField: confirmPasswordTextField) {
            scrollView.scrollRectToVisible(confirmPasswordTextField.frame, animated: true)
            confirmPasswordTextField.becomeFirstResponder()
            return
        }else if !viewModel.agreedToTermsAndConditions {
            let tncagreementAlert = QklyAlertController(title: "Alert", message: "Please agree to our Terms and Conditions before signing up") { alertView in
                alertView.dismiss(animated: true)
            }
            present(tncagreementAlert, animated: true)
            return
        }
        
        _ = viewModel.validateAndSendRequest()
    }
    
//    @IBAction func signinButtonTapped(_ sender: UIButton) {
//
//    }

}

extension CreateAccountController: QBValidationTextFieldDelegate {
    
    func textFieldDidEndEditing(textField: QBValidationTextField) {
        _ = validateTextField(textField: textField)
    }
    
    func textFieldShoudBeginEditing(textField: QBValidationTextField) -> Bool {
        if textField == countryTextField {
            var countryPicker = CountryPicker()
            countryPicker.countrySelected = { country in
                if let country = country {
                    self.viewModel.country = country
                    self.countryTextField.text = country.name
                }
                self.dismiss(animated: true) {
                    self.countryTextField.resignFirstResponder()
                    _ = self.validateTextField(textField: self.countryTextField)
                }
            }
            let vc = getSwiftUIWrapperController(forView: countryPicker)
            present(vc, animated: true)
        }
        return textField != countryTextField
    }
    
}
