//
//  HttpClient.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import Alamofire
import Combine
//import Swime

public class HttpClient: Client {
    
    
    
    /// The parser that will parse the response received from server response
    private let parser: Parser
    
    /// The subscription cleaner
    private var bag = Set<AnyCancellable>()
    
    /// Initializer
    ///
    /// - Parameter parser: the response parser
    public init(parser: Parser) {
        self.parser = parser
    }
    
    /// Method to request data from API using Alamofire
    ///
    /// - Parameters:
    ///   - router: the Almaofire router
    /// - Returns: observable of APIResponse
    public func performRequest<O>(type: O.Type, router: NetworkingRouter,isuploadFile:Bool, parametersdata: [String: Data?]?, params: [String: Any]?,uploadDocumentFrom:UploadDocumentFrom) -> AnyPublisher<NetworkingResult<O>, Never> {
        if isuploadFile {
            
            // upload data for applyjob only
            return Future<NetworkingResult<O>, Never> { [weak self] promise in
                AF.upload(multipartFormData: { (formData) in
                    
                    switch uploadDocumentFrom {
                    case .Applyjob:
                        if let param = parametersdata {
                            for (key, value) in param {
                                if value != nil {
                                    formData.append(value ?? ("null" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key,fileName: "document")
                                }
                            }
                        }
                        //
                        if let params = params {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                                formData.append(jsonData, withName:"request")
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        break
                        
                    case .chatMessage(let fileName):
                        if let param = parametersdata {
                            for (key, value) in param {
                                if value != nil {
                                    formData.append(value ?? ("null" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key,fileName: fileName, mimeType: Swime.mimeType(data: value!)?.mime)
                                    
                                }
                            }
                        }
                        //
                        
                        if let params = params {
                            for (key, value) in params {
                                formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                                
                            }
                        }
                        break
                    case .profilePics:
                        if let paramsD = parametersdata {
                            for (key, value) in paramsD {
                                
                                formData.append(value!, withName: key,fileName: "\(key).png", mimeType: "image/png")
                                
                            }
                        }
                        if let params = params {
                            for (key, value) in params {
                                // formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                                formData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                
                            }
                        }
                        break
                    case .general,.document:
                        if let paramsD = parametersdata {
                            for (key, value) in paramsD {
                                
                                formData.append(value!, withName: key,fileName: "\(key).png", mimeType: "image/png")
                                
                            }
                        }
                        if let params = params {
                            for (key, value) in params {
                                // formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                                formData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                
                            }
                        }
                        break
                        
                    }
                    
                }, with: router).uploadProgress(queue: .main, closure: { (progress) in
                    print("progress: \(progress.fractionCompleted)")
                }).responseJSON { [weak self] (jsonResponse) in
                    guard let self = self else { return }
                    print(jsonResponse)
                    Logger.shared.log(jsonResponse)
                    
                    if jsonResponse.response?.statusCode == 200 {
                        switch jsonResponse.result {
                        case.success(let resultdata):
                            print(resultdata)
                            
                            do {
                                switch uploadDocumentFrom {
                                case .Applyjob:
                                    if let json = try JSONSerialization.jsonObject(with: jsonResponse.data!, options: []) as? [String: Any] {
                                        // try to read out a string array
                                        let error1 = json["errors"] as? String
                                        let result1 = json["result"] as? String
                                        if error1 == nil && result1 != nil  {
                                            //success
                                            promise(.success(NetworkingResult(success: true, error: .none, statusCode: 200, message: result1 ?? "",  router: router,data: jsonResponse.data)))
                                        } else {
                                            promise(.success(NetworkingResult(success: false, error: .custom(error1 ?? ""), router: router)))
                                        }
                                        
                                    }
                                    break
                                case .document,.chatMessage(_),.profilePics,.general:
                                    promise(.success(try self.parser.parseResponse(type: O.self, jsonResponse, router: router)))
                                    break
                                }
                                
                            }  catch {
                                if let error = error as? NetworkingError {
                                    promise(.success(NetworkingResult(success: false, error: error, router: router)))
                                } else {
                                    promise(.success(NetworkingResult(success: false, error: .nonParsableErrorReceived, router: router)))
                                }
                            }
                            
                        case .failure(let error):
                            print(error)
                            promise(.success(NetworkingResult(success: false, error: .none, router: router)))
                        }
                    }
                }
            }.receive(on: RunLoop.main)
                .eraseToAnyPublisher()
            
            
            
        } else {
            return Future<NetworkingResult<O>, Never> { [weak self] promise in
                AF.request(router).validate().responseJSON(completionHandler: { [weak self] (jsonResponse) in
                    guard let self = self else { return }
                    Logger.shared.log(jsonResponse)
                    
                    do {
                        if jsonResponse.response?.statusCode == 401 {
                            promise(.success(NetworkingResult(success: false, error: .custom("Refresh the Token"), statusCode:NetworkingError.unauthorized.code , router: EraserRouter.none)))
                        }
                        promise(.success(try self.parser.parseResponse(type: O.self, jsonResponse, router: router)))
                    } catch {
                        if let error = error as? NetworkingError {
                            promise(.success(NetworkingResult(success: false, error: error, router: router)))
                        } else {
                            promise(.success(NetworkingResult(success: false, error: .nonParsableErrorReceived, router: router)))
                        }
                    }
                })
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }
    
    
}
