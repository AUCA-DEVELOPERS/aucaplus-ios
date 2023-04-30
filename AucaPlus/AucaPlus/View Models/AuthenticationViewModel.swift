//
//  AuthenticationViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 24/04/2023.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var authModel = AuthModel()
    @Published var regModel = RegisterModel()
}

extension AuthenticationViewModel {
    struct AuthModel {
        var countryCode = "250"
        var phone = ""
        
        var email = ""
        var password = ""
                
        func formattedPhone() -> String {
            return "+\(countryCode) \(phone)"
        }
        
        func isValid() -> Bool {
            let isCountryValid = countryCode.trimmingCharacters(in: .whitespaces).count == 3
            let isPhoneValid = phone.trimmingCharacters(in: .whitespaces).count >= 5
            return isCountryValid && isPhoneValid
        }
    }
    
    struct RegisterModel {
        var firstName = ""
        var lastName = ""
        var type = AucaUserType.student
        var email = ""
        var about = ""
        
        func isValid() -> Bool {
            guard firstName.replacingOccurrences(of: " ", with: "").count > 3 else { return false }
            guard lastName.replacingOccurrences(of: " ", with: "").count > 3 else { return false }
            guard email.isValidEmail() else { return false }
            return true
        }
    }
}
