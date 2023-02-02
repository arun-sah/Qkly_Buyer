//
//  DropdownField.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/27/23.
//

import UIKit
import DropDown

@IBDesignable
class DropdownField: UIControl {
    
    var placeholderColor: UIColor = .lightGray
    var textColor: UIColor = .darkText
    
    var placeholder: String = "Choose option"
    var value: String = "" {
        didSet {
            updateValueColor(label: valueLabel)
            updateLabelValue(label: valueLabel)
        }
    }
    
    var label: UILabel {
        get {
            valueLabel
        }
    }
    
    var selectedItemIndex: Int?
    
    var dropdownOptions: [String] = [] {
        didSet {
            dropdown.dataSource = dropdownOptions
        }
    }
    
    private var isPlaceholder: Bool = true {
        didSet {
            updateValueColor(label: valueLabel)
            updateLabelValue(label: valueLabel)
        }
    }
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        updateValueColor(label: label)
        updateLabelValue(label: label)
        return label
    }()
    
    private lazy var dropdown: DropDown = {
        let dropdown = DropDown()
        //dropdown.cornerRadius = 8
        dropdown.anchorView = self
        dropdown.dataSource = dropdownOptions
        dropdown.bottomOffset = CGPoint(x: 0, y: bounds.height)
        dropdown.selectionAction = {(index, item) in
            self.isPlaceholder = false
            self.value = item
            self.selectedItemIndex = index
            self.sendActions(for: .valueChanged)
            self.valueSelected?(index, item)
        }
        return dropdown
    }()
    
    var valueSelected: ((Int, String)->())?
    
    override func draw(_ rect: CGRect) {
        layer.masksToBounds = true
        layer.cornerRadius = 6
        addTarget(self, action: #selector(touchedUpInside), for: .touchUpInside)
        addContainer()
        layoutIfNeeded()
    }
    
    private func updateValueColor(label: UILabel) {
        label.textColor = isPlaceholder ? placeholderColor : textColor
    }
    
    private func updateLabelValue(label: UILabel) {
        label.text = isPlaceholder ? placeholder : value
    }
    
    private func addContainer() {
        let containerView = UIView(frame: bounds)
        containerView.isUserInteractionEnabled = false
        containerView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        let chevronDownImage = UIImage(named: "chevron-down")
        let downImageView = UIImageView(image: chevronDownImage)
        downImageView.contentMode = .scaleAspectFit
        
        containerView.addSubview(downImageView)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        downImageView.translatesAutoresizingMaskIntoConstraints = false
        downImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0).isActive = true
        downImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
        downImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12.0).isActive = true
        
        addSubview(valueLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: downImageView.leftAnchor, constant: -12.0).isActive = true
        valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12.0).isActive = true
    }
    
    @objc private func touchedUpInside() {
        dropdown.show()
    }
    
    //MARK:- Public functions
    
    func clearValue() {
        isPlaceholder = true
        value = ""
        selectedItemIndex = nil
    }
    
}

