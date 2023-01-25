//
//  BaseViewModel.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Combine

/// The baseViewModel for every viewModel
open class BaseViewModel {

    /// The subcription cleanup bag
    public var bag = Set<AnyCancellable>()

    /// Routes trigger
    public var trigger = PassthroughSubject<AppRoutable, Never>()

    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
    /// initializer
    public init() { }
}

