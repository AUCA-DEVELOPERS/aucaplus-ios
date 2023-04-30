//
//  Constants.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 30/04/2023.
//

import Foundation

enum Delays {
    static let onboardingAnimateDelay = DispatchTime.now() + 0.8
    
    static let onboardingDisplayDelay = DispatchTime.now() + 1.3
    
    /// Considering both `onboardingAnimateDelay` and `onboardingDisplayDelay`
    static let authFieldFocusTime = DispatchTime.now() + 1.5
}
