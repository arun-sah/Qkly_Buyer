//
//  ProfilePicture.swift
//  QklyBuyer
//
//  Created by arun sah on 24/01/2023.
//
import Foundation

typealias ProfilePictureResponse = ProfilePicture

struct ProfilePicture: Codable {
    
    let fileId: String?
    let profileName: String?
    let mimeType: String?
    let image: String?
    let smallImage: String?
    
}
