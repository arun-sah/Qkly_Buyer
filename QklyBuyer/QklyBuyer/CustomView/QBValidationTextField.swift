//
//  QBValidationTextField.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/27/23.
//

import UIKit

@objc protocol QBValidationTextFieldDelegate: AnyObject {
    @objc optional func textFieldDidEndEditing(textField: QBValidationTextField)
    @objc optional func textFieldDidChange(text: String, textField: QBValidationTextField)
    @objc optional func textFieldDidBeginEditing(textField: QBValidationTextField)
    @objc optional func textFieldShoudBeginEditing(textField: QBValidationTextField) -> Bool
}

class QBValidationTextField: UIControl {
    
    enum ValidationState {
        case fresh
        case invalid
        case valid
    }
    
    var textfield: UITextField {
        get {
            self.textField
        }
    }
    
    weak var delegate: QBValidationTextFieldDelegate?
    
    var textFieldPlaceholder: String = "" {
        didSet {
            textField.placeholder = textFieldPlaceholder
        }
    }
    
    var titlePlaceholder: String = "" {
        didSet {
            textFieldLabel.text = titlePlaceholder
        }
    }
    
    var text: String {
        get {
            textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }
    
    var textFieldFocus: UIColor = .purple{
        didSet {
            textField.layer.borderColor = textFieldFocus.cgColor
        }
    }
    
    var errorColor: UIColor = .red {
        didSet {}
    }
    
    var validColor: UIColor = UIColor.systemGreen {
        didSet {}
    }
    
    var defaultSupplementaryTextColor: UIColor = .lightText {
        didSet {
            validationMessageLabel.textColor = defaultSupplementaryTextColor
        }
    }
    
    var defaultBackgroundColor: UIColor = UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1.0) {
        didSet {
            textField.backgroundColor = defaultBackgroundColor
        }
    }
    
    var validationState: ValidationState = .fresh
    
    var rightView: UIImageView {
        rightImageView
    }
    
    private lazy var textField: UITextField = {
        let textfield = UITextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16.0, height: 20.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        textfield.font = .appFont(ofSize: .size_16, weight: .regular)
        textfield.backgroundColor = defaultBackgroundColor
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8
        return textfield
    }()
    
    private lazy var validationMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont(ofSize: .size_12, weight: .regular)
        label.textColor = defaultSupplementaryTextColor
        label.text = ""
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var textFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x4D4F5C)
        label.font = .appFont(ofSize: .size_16, weight: .regular)
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 48.0))
        imageview.contentMode = .left
        imageview.image = UIImage(named: "close")
        imageview.isUserInteractionEnabled = true
        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        return imageview
    }()
    
    
    override func draw(_ rect: CGRect) {
        
        let horizontalStackView = UIStackView(arrangedSubviews: [textField])
        horizontalStackView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 48.0)
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = -40.0
        horizontalStackView.axis = .horizontal
        
        let verticalStackView = UIStackView(arrangedSubviews: [textFieldLabel, horizontalStackView, validationMessageLabel])
        verticalStackView.frame = self.bounds
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 8
        verticalStackView.axis = .vertical

        addSubview(verticalStackView)
        
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        validationMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        validationMessageLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        verticalStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        textField.delegate = self
    }
    
    @objc private func imageViewTapped() {
        rightImageView.isHidden = true
        text = ""
    }
    
    func resetAll() {
        text = ""
        validationMessageLabel.text = ""
        validationMessageLabel.isHidden = true
    }
    
    func showValidationMessage(message: String) {
        validationMessageLabel.text = message
    }
    
    func setValidation(state: ValidationState) {
        switch state {
        case .fresh:
            setFocusState(borderColor: nil, backgroundColor: defaultBackgroundColor)
            validationMessageLabel.textColor = defaultSupplementaryTextColor
            break
        case .valid:
            setFocusState(borderColor: validColor, backgroundColor: validColor.withAlphaComponent(0.1))
            validationMessageLabel.textColor = validColor
            break
        case .invalid:
            setFocusState(borderColor: errorColor, backgroundColor: errorColor.withAlphaComponent(0.1))
            validationMessageLabel.textColor = errorColor
            break
        }
    }
    
    func setFocusState(borderColor: UIColor?, backgroundColor: UIColor) {
        if let borderColor = borderColor {
            textField.layer.borderColor = borderColor.cgColor
            textField.layer.borderWidth = 2.0
        }else {
            textField.layer.borderColor = nil
            textField.layer.borderWidth = 0.0
        }
        textField.backgroundColor = backgroundColor
    }
    
    
}

extension QBValidationTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if text == "" {
            setFocusState(borderColor: textFieldFocus, backgroundColor: textFieldFocus.withAlphaComponent(0.1))
        }else{
            setFocusState(borderColor: textFieldFocus, backgroundColor: defaultBackgroundColor)
        }
        delegate?.textFieldDidBeginEditing?(textField: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = (textField.text ?? "") + string
        if string == "" {
            newText.removeLast()
        }
        if newText == "" {
            setFocusState(borderColor: textFieldFocus, backgroundColor: textFieldFocus.withAlphaComponent(0.1))
        }else{
            setFocusState(borderColor: textFieldFocus, backgroundColor: defaultBackgroundColor)
        }
        delegate?.textFieldDidChange?(text: newText, textField: self)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setFocusState(borderColor: nil, backgroundColor: defaultBackgroundColor)
        delegate?.textFieldDidEndEditing?(textField: self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShoudBeginEditing?(textField: self) ?? false
    }
    
}
