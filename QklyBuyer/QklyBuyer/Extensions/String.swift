//
//  String.swift
//  Qkly
//
//  Created by Arun Sah on 12/11/2021.
//

import Foundation
import UIKit




enum AppSupportedFormat: String, CaseIterable {
    case weekdayDayMonth // "Moday, 10 Feb"
    case shortWeekDay
    case hhmm24 // "15:20"
    case hmm12 // "10:30 PM"
    case yymmddThhmmsszline
    case hhmmss24 // "05:30:45"
    case hmmss12 // "10:30:12 PM"
    //case custom(String)
    case yyyyMMDDSlash
    case yyyyMMDDDash
    case yyyyMM
    case yyyy
    case MMMMyyyy // "December 2020"
    case MMyyyy // 12/2020 i.e. month_in_twoDigits/year
    case ddMMM // example: 27 Apr
    case mmddyyyyHHMMSSa   //  "6/26/2022, 11:59:00 PM"
    case yyyyMMDDTHHMMSS// "yyyy-MM-dd'T'HH:mm:ss" //2022-06-19T23:59:00
    case MdYYYYHHMMSSA     //"M/d/YYYY, hh:mm:ss a" //6/13/2022, 12:00:00 AM
    case MMddYYYY
    case MMDDyyyySlash
    case MMMDDyyyycoma
    case EMMMddYYYY  //selectedDate: "Tue Jul 05 2022"
    case yyyyMMddTHHmmssSSSSSSSzzz
    case MMMddYYYYDash // jun-12-2022
    case MMMddYYYYHHmma
    
    var rawValue: RawValue {
        dateFormatString
    }
    
    var dateFormatString: String {
        switch self {
        case .weekdayDayMonth: return "EEEE, dd MMM"
        case .hhmm24: return "HH:mm"
        case .hmm12: return "h:mm a"
        case .yymmddThhmmsszline: return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // server date format
        case .hmmss12: return "h:mm:ss a"
        case .hhmmss24: return "HH:mm:ss"
        //case .custom(let format): return format
        case .yyyyMMDDSlash: return "yyyy/MM/DD"
        case .yyyyMMDDDash: return "YYYY-MM-dd"
        case .yyyyMM: return "MM/yyyy"
        case .yyyy: return "yyyy"
        case .MMMMyyyy: return "MMMM yyyy"
        case .MMyyyy: return "MM/yyyy"
        case .ddMMM: return "dd MMM"
        case .mmddyyyyHHMMSSa: return "MM/dd/yyyy, HH:mm:ss a"
        case .yyyyMMDDTHHMMSS: return "yyyy-MM-dd'T'HH:mm:ss"
        case .MdYYYYHHMMSSA: return "M/d/YYYY, hh:mm:ss a"
        case .shortWeekDay: return "E"
        case .MMddYYYY: return "MMM dd yyyy"
        case .MMDDyyyySlash: return "MM/dd/yyyy"
        case.MMMDDyyyycoma:return "MMM dd, yyy"
        case .EMMMddYYYY: return "E MMM dd YYYY"
        case .yyyyMMddTHHmmssSSSSSSSzzz: return "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSzzz"
        case .MMMddYYYYDash: return "MMM-dd-yyyy"
        case .MMMddYYYYHHmma: return "MMM dd, YYYY hh:mm a"
        }
    }
    
    static func getAppSupportedFormatType(for dateString: String) -> AppSupportedFormat? {
        AppSupportedFormat.allCases.filter({dateString.getDate(format: $0.dateFormatString) != nil}).first
    }
}

extension String {
    /// returns first character of string
    /// - Returns: first character
    func getFirstCharacter() -> String {
        return self.isEmpty ? "" : String(self[..<self.index(self.startIndex, offsetBy: 1)])
    }
    
    func getDate(format: String = AppSupportedFormat.yymmddThhmmsszline.dateFormatString) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let convertedDate = formatter.date(from: self)
        formatter.timeZone = TimeZone(identifier: "UTC")
        guard convertedDate != nil else {return nil}
        let utcDate = formatter.date(from: self)
        return utcDate
    }
    
    func changeDateFormat(fromFormat: String, toFormat: String) -> String {
        let dateFormatter = Date.dateFormatter(locale: Locale.enUSPosix, dateFormat: fromFormat)
        guard let date = dateFormatter.date(from: self) else { return "" }
        let toDateFormatter = Date.dateFormatter(locale: Locale.enUSPosix, dateFormat: toFormat)
        return toDateFormatter.string(from: date)
    }
    func getHHMMSSFromHHMMToUTC() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppSupportedFormat.hhmm24.dateFormatString
        let convertedDate = formatter.date(from: self)
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = AppSupportedFormat.hhmmss24.dateFormatString
        guard let converteddate = convertedDate else { return ""}
        let utcstring = formatter.string(from: converteddate)
        return utcstring
    }
    func getYYYYMMDDFromYYMMToUTC() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppSupportedFormat.yyyyMM.dateFormatString
        let convertedDate = formatter.date(from: self)
       // formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = AppSupportedFormat.yyyyMMDDDash.dateFormatString
        guard let converteddate = convertedDate else { return "" }
        return formatter.string(from: converteddate)
    }
    func getDateFromTimeString() -> Date {
        let formatter = DateFormatter()
        formatter.defaultDate = Date()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        let date = formatter.date(from: self)
        return date!
    }
    func getDateFromTimeString(dateFormat:AppSupportedFormat) -> Date {
        let formatter = DateFormatter()
       // formatter.defaultDate = Date()
        formatter.dateFormat = dateFormat.dateFormatString
     //   formatter.locale = Locale(identifier: "en_US_POSIX")

        let date = formatter.date(from: self)
        return date!
    }
    
    func toFixedFormatDate(withFormat format: AppSupportedFormat = .yymmddThhmmsszline, locale: Locale = Locale(identifier: "en_US_POSIX"), timeZome: TimeZone? = TimeZone(abbreviation: "utc")) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZome
        dateFormatter.dateFormat = format.dateFormatString
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

// MARK: - phone number formatter
extension String {
    /// trim whitespace of string
    var trim: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var adjustHTMLContent: String {
        "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>@font-face {font-family: 'SourceSansPro';src: url(\"SourceSansPro-Regular.ttf\") format('truetype');}body {font-size: 15px;font-family: \"SourceSansPro\";}</style></header>" + self
    }

    func stripOutHtml() -> String? {
        guard self != "" else {return nil}
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
    
    func removePTag() -> String {
        self.replacingOccurrences(of: "(?i)<p[^>]*>", with: "", options: .regularExpression).replacingOccurrences(of: "(?i)</p[^>]*>", with: "", options: .regularExpression)
    }
    
    func validateEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    func validatePassword() -> Bool {
        let passwordFormat = #"(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s)[0-9a-zA-Z!@#$%^&*()-^*]*$"#
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
    
    /// mask for australian contact number
    static let australianContactMask: String = { return "xxxx xxx xxx" }()
    
    /// mask example: `+X (XXX) XXX-XXXX`
    func format(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for maskCharacter in mask where index < numbers.endIndex {
            if maskCharacter == "x" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(maskCharacter) // just append a mask character
            }
        }
        return result
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    var httpSafeURLString: String{
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            return self
        }else{
            return "https://" + self
        }
    }
    
}

extension String {
    func stringToBinary() -> String {
        let st = self
        var result = ""
        for char in st.utf8 {
            var tranformed = String(char, radix: 2)
            while tranformed.count < 8 {
                tranformed = "0" + tranformed
            }
            let binary = "\(tranformed) "
            result.append(binary)
        }
        return result
    }
    func setAttributes(fontStyle: UIFont, lineHeight: CGFloat? = nil, textColor: UIColor = UIColor.white, characterSpacing: Double = 0.0, alignment: NSTextAlignment = NSTextAlignment.left, underlineStyle: NSUnderlineStyle? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(fontStyle: fontStyle, lineHeight: lineHeight, textColor: textColor, characterSpacing: characterSpacing, alignment: alignment)
        if let style = underlineStyle {
            attributedString.addAttributes([NSAttributedString.Key.underlineStyle: style.rawValue, NSAttributedString.Key.underlineColor: textColor], range: NSRange(location: 0, length: attributedString.string.count))
        }

        return attributedString
    }
    
}


public extension NSMutableAttributedString {
    /// font atribute generator to apply to NSattributedStrings. returns [NSMutableAttributedString.Key: Any]
    /// - Parameters:
    ///   - fontStyle: font name in string defaults to "Gotham-Book"
    ///   - fontSize: font size in CGFloat defaults to 16
    ///   - maxLineHeight: maximum line height
    ///   - textColor: text color defaults to white
    func addAttributes(fontStyle: UIFont, lineHeight: CGFloat? = nil, textColor: UIColor = UIColor.white, characterSpacing: Double = 0.0, alignment: NSTextAlignment = NSTextAlignment.left) {

        let attributedDict = Attribute.getAttributes(fontStyle: fontStyle, lineHeight: lineHeight, textColor: textColor, characterSpacing: characterSpacing, alignment: alignment)

        self.addAttributes(attributedDict, range: NSRange(location: 0, length: self.string.count))
    }
}



public struct Attribute {
    /// font atribute generator to apply to NSattributedStrings. returns [NSMutableAttributedString.Key: Any]
    /// - Parameters:
    ///   - fontStyle: font name in string defaults to "Gotham-Book"
    ///   - fontSize: font size in CGFloat defaults to 16
    ///   - maxLineHeight: maximum line height
    ///   - textColor: text color defaults to white
    public static func getAttributes(fontStyle: UIFont, lineHeight: CGFloat? = nil, textColor: UIColor = UIColor.white, characterSpacing: Double = 0.0, alignment: NSTextAlignment = NSTextAlignment.left) -> [NSAttributedString.Key : Any]{

        let paraStyle = NSMutableParagraphStyle()

        if let lineHt = lineHeight {
            paraStyle.maximumLineHeight = lineHt
            paraStyle.minimumLineHeight = lineHt
        } else {
            paraStyle.maximumLineHeight = fontStyle.pointSize + 1
            paraStyle.minimumLineHeight = fontStyle.pointSize + 1
        }
        paraStyle.alignment = alignment

        let attributeDict: [NSMutableAttributedString.Key: Any] = [
            .font: fontStyle,
            .paragraphStyle: paraStyle,
            .foregroundColor: textColor,
            .kern: characterSpacing
        ]

        return attributeDict
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension Int {
    var nonNegative: Int {
        clamped(to: 0...Int.max)
    }
}

extension Collection {
    var tailLength: Int {
        (count - 1).nonNegative
    }

    var head: SubSequence { prefix(1) }
    var tail: SubSequence { suffix(tailLength) }
}

extension String {
    var uppercaseFirst: String {
        head.localizedUppercase + tail
    }
    
    var words: [String] {
        components(separatedBy: " ")
    }
    
    var uppercaseFirstWords: String {
        words
        .map(\.uppercaseFirst)
        .joined(separator: " ")
    }
    
}

extension String {
    func containsWhitespaceAndNewlines() -> Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
}


 extension String {
    func convertDate(toFormat: AppSupportedFormat, fromFormat: AppSupportedFormat, useLocalConversion: Bool = false) -> String? {
        guard let date = self.toFixedFormatDate(withFormat: fromFormat, timeZome: useLocalConversion ? TimeZone(abbreviation: "UTC") : TimeZone(abbreviation: "utc")) else { return nil }
        return date.toFixedString(format: toFormat)
    }
}
