//
//  CheckRoundButton.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/31/23.
//

import UIKit

class CheckRoundButton: UIButton {
    
    @Published var isChecked: Bool = false {
        didSet {
            updateImage(isSelected: isChecked)
        }
    }
    
    override func awakeFromNib() {
        updateImage(isSelected: isChecked)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func updateImage(isSelected: Bool) {
        setImage(UIImage(named: isSelected ? "check-round-on" : "check-round-off"), for: .normal)
    }
    
    @objc private func buttonTapped() {
        isChecked = !isChecked
    }
    
}
