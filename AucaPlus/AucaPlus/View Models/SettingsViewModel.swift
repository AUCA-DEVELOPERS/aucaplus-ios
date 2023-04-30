//
//  SettingsViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation

final class SettingsStore: ObservableObject {
    @Published var currentUser: (any AucaUser)? = AucaStudent.example
}
