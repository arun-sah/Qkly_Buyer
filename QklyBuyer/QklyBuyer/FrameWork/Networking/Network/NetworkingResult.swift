//
//  NetworkingResult.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation


public struct NetworkingResult<R>: ResultMaker {
    public var success: Bool
    public var error: NetworkingError
    public var result: R?
    public var statusCode: Int
  //  public var pagination: Pagination?
    public var message: String
    public var title: String
    public var router: NetworkingRouter
    public var data: Data?
    
    public init(success: Bool = true, error: NetworkingError = .none, result: R? = nil, statusCode: Int = 0, title: String = "", message: String = "", router: NetworkingRouter, data:Data? = nil) {
        self.success = success
        self.error = error
        self.result = result
        self.statusCode = statusCode
       // self.pagination = pagination
        self.message = message
        self.title = title
        self.router = router
        self.data = data
    }
}
