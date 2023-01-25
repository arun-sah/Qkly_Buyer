//
//  Token.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//


import Foundation

/// The data transfer object for Token model
public struct Token: Codable {
    public var refreshToken: String
    public var accessToken: String
    public var expiresIn: Date
    public var accessTokenExpiresIn: Date
    public var refreshedDate: Date
    public var accountIdentifier: String
    
      enum CodingKeys: String, CodingKey {
          case accessToken
          case refreshToken
          case expiresIn
          case accessTokenExpiresIn
          case refreshedDate
          case accountIdentifier
      }
      
      //making compiler happy
      public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)
          try container.encode(accessToken, forKey: .accessToken)
          try container.encode(refreshToken, forKey: .refreshToken)
          try container.encode(expiresIn, forKey: .expiresIn)
          try container.encode(accessTokenExpiresIn, forKey: .accessTokenExpiresIn)
          try container.encode(refreshedDate, forKey: .refreshedDate)
          try container.encode(accountIdentifier, forKey: .accountIdentifier)
      }
      
      public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          self.accessToken    = try container.decode(String.self, forKey: .accessToken)
          self.refreshToken   = try container.decode(String.self, forKey: .refreshToken)
          self.expiresIn  = Date()
          self.refreshedDate  = Date()
          self.accessTokenExpiresIn  = Date()
          self.accountIdentifier = try container.decodeIfPresent(String.self, forKey: .accountIdentifier) ?? ""
      }
  }
