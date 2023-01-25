//
//  Date.swift
//  Qkly
//
//  Created by Asmin Ghale on 12/15/21.
//

import Foundation

extension Date {
    var formattedTimeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    static func dateFormatter(timeZone: TimeZone? = nil, locale: Locale? = nil, dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        
        // set time zone
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        
        // set locale
        if let locale = locale {
            dateFormatter.locale = locale
        }
        
        // set date format
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
    static func dateFormatter(timeZone: TimeZone? = nil, locale: Locale? = nil, dateFormat: AppSupportedFormat) -> DateFormatter {
        return Date.dateFormatter(timeZone: timeZone, locale: locale, dateFormat: dateFormat.dateFormatString)
    }
    func toString( dateFormat format  : String ) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: self)
        }
    func tolocaleString( dateFormat format  : String ) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
          //  dateFormatter.locale = Locale.enUSPosix
            return dateFormatter.string(from: self)
        }


}

 extension Date {
    
    func toUTCString(format: AppSupportedFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.dateFormatString
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
    
    func toFixedString(format: AppSupportedFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format.dateFormatString
        return dateFormatter.string(from: self)
    }
}


public extension Locale {
    
    /// en_US_POSIX locale
    static var enUSPosix: Locale = { return Locale(identifier: "en_US_POSIX") }()
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
