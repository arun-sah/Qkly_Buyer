//
//  PhoneNumberFormatter.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//


import Foundation

struct PhoneNumberFormatter{
    
    let rawValue: String
    
    var countryCode: String {
        countryCode(string: rawValue)
    }
    var phoneNumber: String {
        phoneNumber(string: rawValue)
    }
    
    var formattedCountryCode: String {
        "+\(countryCode)"
    }
    
    var formattedPhoneNumber: String {
        PhoneNumberFormatter.format(with: "XXX-XXX-XXXXX", phone: phoneNumber)
    }
    
    var formattedFullNumber: String {
        addMask(code: countryCode, number: phoneNumber)
    }
    
    init(number: String) {
        self.rawValue = number
    }
    
    private func removeMask(string: String) -> String {
        let stripped = string.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
        return stripped
    }
    
    private func phoneNumber(string: String) -> String {
        guard let phoneNumber = string.split(separator: "-", maxSplits: 1, omittingEmptySubsequences: false).last else {return string}
        return removeMask(string: String(phoneNumber))
    }
    
    private func countryCode(string: String) -> String {
        guard let phoneNumber = string.split(separator: "-", maxSplits: 1, omittingEmptySubsequences: false).first else {return string}
        return removeMask(string: String(phoneNumber))
    }
    
    private func addMask(code: String, number: String) -> String {
        let sCode = removeMask(string: code)
        let sNumber = removeMask(string: number)
        
        let num = "+\(sCode)-" + PhoneNumberFormatter.format(with: "XXX-XXX-XXXXX", phone: sNumber)
        return num
    }
    
    static func addMask(code: String, number: String) -> String {
        let sCode = code.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
        let sNumber = number.replacingOccurrences(of: "-", with: "")
        
        let num = "+\(sCode)-" + PhoneNumberFormatter.format(with: "XXX-XXX-XXXXX", phone: sNumber)
        return num
    }
    
    static func addMask(number: String) -> String {
        let num = PhoneNumberFormatter.format(with: "XXX-XXX-XXXXX", phone: number)
        return num
    }
    
    static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
}
