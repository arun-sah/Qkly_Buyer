//
//  ValueOrError.swift
//  Qkly
//
//  Created by Arun Sah on 12/11/2021.
//

import Foundation
struct ValueOrError<T> {
    /// the title for error
    var title: String
    
    /// the error message
    var error: String
    
    /// the actual data
    var value: T?
}

