//
//  BaseController.swift
//  Qkly
//
//  Created by Arun Sah on 12/11/2021.
//


import Foundation
import UIKit
import SideMenuSwift
import Photos

extension BaseController {
    
    func showHUD(disableInteraction:Bool = false) {
     //   QklyProgressIndicatorLoader.show(darklayerEnable: disableInteraction)
        
        // it will dismiss automatically after 60 sec.
        Timer.scheduledTimer(withTimeInterval: 60, repeats: false) {  (t) in
            self.hideHUD()
        }
    }

    func hideHUD() {
     //   QklyProgressIndicatorLoader.hide()
    }
      
       
    /// adds back button
//    func addBackButton() {
//        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage.backArrow?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
//        backButton.setBackgroundImage(UIImage.backBg, for: .normal, barMetrics: .default)
//        self.navigationItem.leftBarButtonItem = backButton
//    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutButtonTapped() {
        
    }
//    func addMenuButton() {
////        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage.back?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
//        let menuButton: UIBarButtonItem = UIBarButtonItem(image: UIImage.menuIcon?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(MenuButtonPressed))
//        menuButton.setBackgroundImage(UIImage.menuIcon, for: .normal, barMetrics: .default)
//        self.navigationItem.leftBarButtonItem = menuButton
//    }
    
    @objc func MenuButtonPressed() {
        sideMenuController?.revealMenu()
    }
    
    /// adds right bar button with given title
    /// - Parameter title: title text
    func addRightBarButton(title: String, textAttributes: [NSAttributedString.Key: Any]? = nil) {
        let logoutButton: UIBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        if let titleTextAttributes = textAttributes {
            logoutButton.setTitleTextAttributes(titleTextAttributes, for: .normal)
            self.navigationItem.rightBarButtonItem = logoutButton
        }

    }
    
    func addRightBarButton(image: UIImage) {
        let button: UIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        self.navigationItem.rightBarButtonItem = button

    }
    
    @objc func rightBarButtonTapped() {
        
    }
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    func requestAuthorization(completion: @escaping ()->Void) {
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            } else if PHPhotoLibrary.authorizationStatus() == .authorized{
                completion()
            }
        }
   
}

extension BaseTableController {
    
    func showHUD(darkLayerEnable: Bool = false) {
     //   QklyProgressIndicatorLoader.show(darklayerEnable: darkLayerEnable)
    }

    func hideHUD() {
      //  QklyProgressIndicatorLoader.hide()
    }
    /// adds back button
//    func addBackButton() {
//        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage.back?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
//        self.navigationItem.leftBarButtonItem = backButton
//    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addRightBarButton(image: UIImage) {
        let button: UIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        self.navigationItem.rightBarButtonItem = button

    }
    
    
    
    @objc func logoutButtonTapped() {
        
    }
   
    
    /// adds right bar button with given title
    /// - Parameter title: title text
    func addRightBarButton(title: String, textAttributes: [NSAttributedString.Key: Any]? = nil) {
        let logoutButton: UIBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        if let titleTextAttributes = textAttributes {
            logoutButton.setTitleTextAttributes(titleTextAttributes, for: .normal)
            self.navigationItem.rightBarButtonItem = logoutButton
        }

    }
    
    @objc func rightBarButtonTapped() {
        
    }
   
}

import SafariServices
import UniformTypeIdentifiers

   // case image,text,plainText,utf8PlainText,utf16ExternalPlainText


enum DocumentType{
    //add types from here..
////////        UTType.image, UTType.text, UTType.plainText, UTType.utf8PlainText,    UTType.utf16ExternalPlainText, UTType.utf16PlainText,    UTType.delimitedText, UTType.commaSeparatedText,    UTType.tabSeparatedText, UTType.utf8TabSeparatedText, UTType.rtf,    UTType.pdf, UTType.webArchive, UTType.image, UTType.jpeg,    UTType.tiff, UTType.gif, UTType.png, UTType.bmp, UTType.ico,    UTType.rawImage, UTType.svg, UTType.livePhoto, UTType.movie,    UTType.video, UTType.audio, UTType.quickTimeMovie, UTType.mpeg,    UTType.mpeg2Video, UTType.mpeg2TransportStream, UTType.mp3,    UTType.mpeg4Movie, UTType.mpeg4Audio, UTType.avi, UTType.aiff,    UTType.wav, UTType.midi, UTType.archive, UTType.gzip, UTType.bz2,    UTType.zip, UTType.appleArchive, UTType.spreadsheet, UTType.epub
    case image
    case pdf
    case rtf
    
    var type: UTType {
        switch self{
        case .image:
            return UTType.image
        case .pdf:
            return UTType.pdf
        case .rtf:
            return UTType.rtf
        }
    }
    
}


extension UIViewController {
    
    func presentWeb(withURL url: URL) {
        let sf = SFSafariViewController(url: url)
        sf.modalPresentationStyle = .fullScreen
        present(sf, animated: true, completion: nil)
    }
    
    func presentDocumentPicker(types: [DocumentType]) {
        let supportedTypes = types.map({$0.type})
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        if let self = self as? UIDocumentPickerDelegate{
            documentPicker.delegate = self
        }
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
    }
    
}

import PDFKit
import QuickLookThumbnailing

extension UIViewController {
    
    private func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
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

    func thumbnail(for fileURL: URL, width: CGFloat = 240, completion: @escaping(_ image: UIImage?)->()) {
        
        if let image = pdfThumbnail(url: fileURL) {
            completion(image)
            return
        }
        
        let size = UIScreen.main.bounds
        let scale = width / size.width
        
        let request = QLThumbnailGenerator
            .Request(fileAt: fileURL, size: size.size, scale: scale,
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
    
    
}

import SwiftUI

extension BaseController {
    
    func getSwiftUIWrapperController(forView view: some View) -> UIViewController {
        UIHostingController(rootView: view)
    }
    
}
