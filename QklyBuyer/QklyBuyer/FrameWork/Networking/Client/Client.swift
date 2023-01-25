//
//  Client.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Combine
import Foundation

public enum UploadDocumentFrom {
    case Applyjob
    case chatMessage(String)
    case profilePics
    case general
    case document
}


public protocol Client {
    func performRequest<O>(type: O.Type, router: NetworkingRouter,isuploadFile:Bool, parametersdata: [String: Data?]?, params: [String: Any]?,uploadDocumentFrom:UploadDocumentFrom) -> AnyPublisher<NetworkingResult<O>, Never>
   
}
