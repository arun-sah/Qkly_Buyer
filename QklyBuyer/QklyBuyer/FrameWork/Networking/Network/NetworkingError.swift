//
//  NetworkingError.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//


import Foundation

public enum NetworkingError: LocalizedError {
    case none
    case malformedDataReceived
    case nonParsableErrorReceived
    case tokenValidationFailed
    case tokenRefreshFailed(Error?)
    case failedReason(String, Int)
    case noInternetConnection
    case facebookCancelled
    case custom(String)
    case requestTimedOut
    case badGateway
    case gatewayTimeout
    case unauthorized
    case unexpectedErrorOccurred
    
    public var localizedDescription: String {
        switch self {
        case .none, .facebookCancelled: return ""
        case .malformedDataReceived:
            return "Data couldn't be read from server. Please try again later."
        case .nonParsableErrorReceived:
            return "Data couldn't be parsed from response. Please try again later."
        case .failedReason(let reason, _): return reason
        case .noInternetConnection:
            return "The internet connection appears to be offline."
        case .custom(let msg):
            return msg
        case .tokenValidationFailed:
            return "Unable to validate the access token for request"
        case .tokenRefreshFailed(let error):
            return "Token refresh failed \(error?.localizedDescription ?? "")"
        case .requestTimedOut:
            return "The request timed out."
        case .badGateway:
            return "Server Error (502 Bad Gateway)"
        case .gatewayTimeout:
            return "Server Error (504 Gateway Timeout)"
        case .unauthorized:
            return "Unauthorized user"
         
        case .unexpectedErrorOccurred:
            return "Unexpected error occurred"
        }
    }
    
    public var code: Int {
        switch self {
        case .failedReason(_, let code):
            return code
        case .badGateway:
            return 502
        case .gatewayTimeout:
            return 504
        case .unauthorized:
            return 401
        default:
            return 0
        }
    }
}
