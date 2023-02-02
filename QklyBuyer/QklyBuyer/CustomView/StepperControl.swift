//
//  StepperControl.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/27/23.
//

import UIKit

@IBDesignable
class StepperControl: UIControl{
    
    var textColor: UIColor = UIColor(red: 13/255, green: 28/255, blue: 46/255, alpha: 1) {
        didSet {
            valueLabel.textColor = textColor
        }
    }
    
    var controlEnabledColor: UIColor = UIColor(red: 113/255, green: 114/255, blue: 125/255, alpha: 1) {
        didSet {

        }
    }
    
    var controlDisabledColor: UIColor = UIColor(red: 113/255, green: 114/255, blue: 125/255, alpha: 1) {
        didSet {
            valueLabel.textColor = textColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateButtonColor()
        }
    }

    var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"

            increaseButton.isEnabled = value != maximumValue
            decreaseButton.isEnabled = value != minimumValue
            
            updateButtonColor()
        }
    }
    
    var minimumValue: Int = 0
    var maximumValue: Int = 10
    
    var stepValue: Int = 5
    
    @IBInspectable var buttonSize: CGFloat = 20.0 {
        didSet {
            decreaseButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            decreaseButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            increaseButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            increaseButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            
            decreaseButton.layer.cornerRadius = buttonSize / 2
            increaseButton.layer.cornerRadius = buttonSize / 2
            
            self.layoutIfNeeded()
        }
    }
    
    lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.setImage(UIImage(named: "stepper-minus"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .lightGray
        
        button.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.setImage(UIImage(named: "stepper-plus"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .lightGray
        
        button.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 13/255, green: 28/255, blue: 46/255, alpha: 1)
        label.text = "\(value)"
        label.textAlignment = .center
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        addSubViews()
        updateButtonColor()
    }
    
    private func updateButtonColor() {
        decreaseButton.backgroundColor = decreaseButton.isEnabled ? UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1) : UIColor(red: 219/255, green: 220/255, blue: 221/255, alpha: 1)
        increaseButton.backgroundColor = increaseButton.isEnabled ? UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1) : UIColor(red: 219/255, green: 220/255, blue: 221/255, alpha: 1)
    }
    
    private func addSubViews() {
        let horizontalStackView = UIStackView(arrangedSubviews: [decreaseButton, valueLabel, increaseButton])
        horizontalStackView.frame = self.bounds
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 5
        horizontalStackView.axis = .horizontal

        addSubview(horizontalStackView)
        horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc private func decreaseButtonTapped() {
        guard value > minimumValue else { return }
        value -= stepValue
        sendActions(for: .valueChanged)
    }
    
    @objc private func increaseButtonTapped() {
        guard value < maximumValue else { return }
        value += stepValue
        sendActions(for: .valueChanged)
    }
    
}
