//
//  LoginController.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 2/2/23.
//

import UIKit

class LoginController: BaseController {
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    //MARK:- NAVIGATION BAR OUTLETS
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navView: UIView!

    @IBOutlet weak var upperNavView: UIView!
    @IBOutlet weak var navImageView: UIImageView!

    @IBOutlet weak var navViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var createAccountMinorLabe: UILabel!

    @IBOutlet weak var createAccountLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAcountBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var contentStackView: UIStackView!
    
    var originalHeightConstraint: CGFloat = 200.0
    var originalLeftConstraint: CGFloat = 20.0
    var originalBottomConstraint: CGFloat = 40.0
    
    private var lastContentOffset: CGFloat = 0
    
    //MARK:- FORM OUTLETS
    
    @IBOutlet weak var emailTextField: QBValidationTextField!
    @IBOutlet weak var passwordTextField: QBValidationTextField!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var loginButton: FormActionButton!
    @IBOutlet weak var biometricButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        scrollView.delegate = contentStackView.bounds.height > scrollView.bounds.height ? self : nil
        upperNavView.layer.opacity = 0

        setupFields()
        bindValues()

        switch viewModel.biometricType {
        case .none:
            biometricButton.isHidden = true
        case .touchID:
            biometricButton.setImage(.icon_fingerprint, for: .normal)
        case .faceID:
            biometricButton.setImage(.icon_faceid, for: .normal)
        @unknown default:
            biometricButton.isHidden = true
        }
    }
    
    func setupFields() {
        emailTextField.titlePlaceholder = "Email"
        emailTextField.textFieldPlaceholder = "Enter your email"
        passwordTextField.titlePlaceholder = "Password"
        passwordTextField.textFieldPlaceholder = "Type password here"

        passwordTextField.textfield.isSecureTextEntry           = true

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func bindValues() {

        emailTextField.textfield.textPublisher.sink {[weak self] value in
            guard let self else {return}
            self.viewModel.email = value
        }.store(in: &viewModel.bag)

        passwordTextField.textfield.textPublisher.sink {[weak self] value in
            guard let self else {return}
            self.viewModel.password = value
        }.store(in: &viewModel.bag)

        loginButton.formButtonTapped.receive(on: RunLoop.main).sink { _ in
            print("t")
        }
        
    }
    
    func validateTextField(textField: QBValidationTextField) -> Bool{
        var isValid = false
        var message = ""

        switch textField {
        case emailTextField:
            isValid = viewModel.emailValidationState.value.0
            message = viewModel.emailValidationState.value.1
            break
        case passwordTextField:
            isValid = viewModel.passwordValidationState.value.0
            message = viewModel.passwordValidationState.value.1
            break
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
    
}

extension LoginController: QBValidationTextFieldDelegate {
    
    func textFieldDidEndEditing(textField: QBValidationTextField) {
        _ = validateTextField(textField: textField)
    }
    
}
