//
//  AucaStudent.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation

struct AucaStudent: AucaUser {
    var id: Int
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var type: AucaUserType
    var about: String?
    var picture: URL?
}

extension AucaStudent {
    static let example = AucaStudent(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "+250788123450", type: .student, about: "I'm a computer science student at AUCA.", picture: URL(string: "https://picsum.photos/200"))

    static let example1 = AucaStudent(id: 1, firstName: "Grace", lastName: "Uwase", phoneNumber: "+250788123456", type: .student, about: "I'm a computer science student at AUCA.", picture: URL(string: "https://picsum.photos/200"))
}
