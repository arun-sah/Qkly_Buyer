//
//  Util.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import Foundation
import UIKit
import QuickLookThumbnailing
import PDFKit
import KeychainSwift

class Util: NSObject {
    class func removeAllUserData() {
        let userDefaultCacheManager = UserDefaultCacheManagerFactory.get()
        let userInfodata = userDefaultCacheManager.get(String.self, forKey: FrameworkCacheKey.userLocationDetailFromAPIJson) ?? ""
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
     
        userDefaultCacheManager.set(String.self, value: userInfodata, key: FrameworkCacheKey.userLocationDetailFromAPIJson)
        UserDefaults.standard.synchronize()
        
    }
    
    class func rounded(value: Double, by: Int) -> Double {
        round(value * Double(by)) / Double(by)
    }
    
    class func thumbnail(for fileURL: URL, width: CGFloat = 240, completion: @escaping(_ image: UIImage?)->()) {
        
        if let image = pdfThumbnail(url: fileURL) {
            completion(image)
            return
        }
        
        let size = CGSize(width: UIScreen.main.bounds.width/2, height: 140)//UIScreen.main.bounds
        let scale = 1//width / size.width
        
        let request = QLThumbnailGenerator
            .Request(fileAt: fileURL, size: size, scale: CGFloat(scale),
                     representationTypes: .lowQualityThumbnail)
        
        QLThumbnailGenerator.shared.generateRepresentations(for: request)
        { (thumbnail, type, error) in
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {
                    completion(nil)
                } else {
                    completion(thumbnail?.uiImage)
                }
            }
        }
    }
    
    private class func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
              let page = PDFDocument(data: data)?.page(at: 0) else {
            return nil
        }
        
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    
    private class func pdfThumbnail(document: PDFDocument, width: CGFloat = 240) -> UIImage? {
        guard let page = document.page(at: 0) else {return nil}
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    class func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString()
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
   class func hhmmToMinutes(_ hhmm : String) -> Int {
        let components = hhmm.components(separatedBy: ":")
        guard components.count == 2,
              let hr = Int(components[0]),
              let mn = Int(components[1]) else { return 0 }
        return hr * 60 + mn
    }
    
   class func minutesToHourMinute(_ minutes : Int) -> String {
        let hr = minutes / 60
        let mn = minutes % 60
        return String(format: "%02ld:%02ld", hr, mn)
    }
   class func getCurrentTimeZone() -> String {
        let localTimeZoneAbbreviation: Int = TimeZone.current.secondsFromGMT()
        let gmtAbbreviation = -(localTimeZoneAbbreviation / 60)
        return "\(gmtAbbreviation)"
    }
    
    class func getDeviceID() -> String? {
        if let id = KeychainSwift().get(Constant.KeychainKey.deviceID.rawValue) {
            return id
        }else{
            if let token = UIDevice.current.identifierForVendor?.uuidString {
                KeychainSwift().set(token, forKey: Constant.KeychainKey.deviceID.rawValue, withAccess: .accessibleWhenUnlockedThisDeviceOnly)
                return token
            }else{
                return nil
            }
        }
    }
  class func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    class func readPlistValue(key: String) -> String{
        guard let plist = Util.readPlist(plistName: "Info") else{
            fatalError("Could not read plist.")
        }
        guard let value = plist.value(forKey: key) as? String else{
            fatalError("no value for \(key)found.")
        }
        return value
    }
    static func readPlist(plistName: String = "Keys") -> NSDictionary? {
          // Read plist from bundle and get Root Dictionary out of it
          var dictRoot: NSDictionary?
          if let path = Bundle.main.path(forResource: plistName, ofType: "plist") {
              dictRoot = NSDictionary(contentsOfFile: path)
              if let dict = dictRoot
              {
                  return dict
              }
          }
          return nil
      }
}


struct Configuration {
    static func getvalue(for key :String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) else
        {
            return ""
            
        }
        return (value as? String)!
    }
}
