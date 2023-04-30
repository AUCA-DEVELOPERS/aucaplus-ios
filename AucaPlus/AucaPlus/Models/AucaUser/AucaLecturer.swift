//
//  AucaLecturer.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation

struct AucaLecturer: AucaUser {
    var id: Int
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var type: AucaUserType
    var about: String?
    var picture: URL?
}
