//
//  OperationQueueable.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Combine

/// The operation queueable protocol for Operation
public protocol OperationQueueable {
    func start()
    var trigger: PassthroughSubject<SynchronizerState, Never> { get set }
}
