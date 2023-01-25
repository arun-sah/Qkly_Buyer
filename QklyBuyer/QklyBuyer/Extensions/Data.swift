//
//  Data.swift
//  Qkly
//
//  Created by Asmin Ghale on 7/25/22.
//

import Foundation

extension Data {
    
    var hexString: String {
        map { String(format: "%02.2hhx", $0) }.joined()
    }
    
}
