//
//  FormActionButton.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/31/23.
//

import UIKit
import Combine

class FormActionButton: UIButton {
    
    var formButtonTapped = PassthroughSubject<Any, Never>()
    
    override func awakeFromNib() {
        backgroundColor = .app_primary_purple
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .appFont(ofSize: 16.0, weight: .medium)
        round(cornerRadius: 4.0)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        formButtonTapped.send("")
    }
    
}
