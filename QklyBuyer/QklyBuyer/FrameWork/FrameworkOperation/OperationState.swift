//
//  OperationState.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation

enum OperationState: Int {
    case ready
    case executing
    case finished
    
    var queueKeyPath: String {
        switch self {
        case .ready: return "isReady"
        case .executing: return "isExecuting"
        case .finished: return "isFinished"
        }
    }
}

/// The states protocol
public protocol ResultMaker { }

/// The state of the operation queueable
///
/// - progress: the synschronizer is sending progress
/// - userDataModified: the state to indicate current user data has been modified
/// - finished: the synchronizer has finished its work
public enum SynchronizerState {
    
    /// Operation queue state
    case suspendQueue
    case resumeQueue
    case terminate
    case completed(ResultMaker)
    case pending(ResultMaker)
}

