//
//  AppKeys.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 30/04/2023.
//

import Foundation

enum Storagekeys {
    static let isLoggedIn = "user:isLoggedIn"
    
    static let appSelectedTab = "settings:appSelectedTab"
    
    static func clearAll() {
        let defaults = UserDefaults.standard
        if let bundID = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundID)
        }
        
        defaults.synchronize()
    }
}
