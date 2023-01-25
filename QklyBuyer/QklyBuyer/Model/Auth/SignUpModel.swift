//
//  SignUpModel.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//



public struct SignUpModel: Codable {
    public var token: String?
    public var id: String?
    public var duplicateUser: Bool?
    public var isSuccess: Bool?
    public var message: String?


    enum CodingKeys: String, CodingKey {
        case token
        case id
        case duplicateUser
        case isSuccess
        case message
    }
    
    //making compiler happy
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(token, forKey: .token)
        try container.encode(id, forKey: .id)
        try container.encode(duplicateUser, forKey: .duplicateUser)
        try container.encode(isSuccess, forKey: .isSuccess)
        try container.encode(message, forKey: .message)

        
    }
    
    public init(from decoder: Decoder) throws {
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.token              = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        self.id               = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.duplicateUser                  = try container.decodeIfPresent(Bool.self, forKey: .duplicateUser) ?? false
        self.message              = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        self.isSuccess                  = try container.decodeIfPresent(Bool.self, forKey: .isSuccess) ?? false

       
    }
}
