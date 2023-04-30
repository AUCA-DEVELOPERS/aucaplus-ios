//
//  String+Extensions.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 02/04/2023.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        // regular expression pattern for email validation
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        do {
            // create a regular expression object with the pattern
            let regex = try NSRegularExpression(pattern: pattern)
            
            // match the regular expression against the email string
            let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
            
            // if there is at least one match, the email is valid
            return matches.count > 0
        } catch {
            // if there is an error creating the regular expression, the email is not valid
            return false
        }
    }
    
    func removingWhitespaces() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        
        return results.map { String($0) }
    }
    
    static func formattedCDIPhoneNumber(from string: String) -> String {
        let components: Int = 9
        
        let compactedSubStringNumber = string.removingWhitespaces()
            .filter({ $0.isNumber })
        
        var compactedSubString: String
        
        if compactedSubStringNumber.count > 10 {
            compactedSubString = String(compactedSubStringNumber.suffix(components))
        } else {
            compactedSubString = String(compactedSubStringNumber.prefix(components))
        }
        
        let newString = String(compactedSubString)
            .split(by: 3)
            .joined(separator: " ")
        
        return newString
    }
}
