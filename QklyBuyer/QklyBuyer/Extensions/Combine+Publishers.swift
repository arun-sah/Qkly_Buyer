//
//  Combine+Publishers.swift
//  QklyBuyer
//
//  Created by Asmin Ghale on 1/30/23.
//

import UIKit
import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
                    for: UITextField.textDidChangeNotification,
                    object: self
                )
                .compactMap { ($0.object as? UITextField)?.text }
                .eraseToAnyPublisher()
    }
    
}
