//
//  AucaUserType.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation

enum AucaUserType: String, CaseIterable, Codable {
    case student
    
    case lecturer
    
    case staff
    
    case other
}

extension AucaUserType {
    var description: String {
        switch self {
        case .student:
            return "A user who is a student at the institution."
        case .lecturer:
            return "A user who is a lecturer or teacher at the institution."
        case .staff:
            return "A user who is a staff member or employee at the institution, but not a lecturer or student."
        case .other:
            return "A user who doesn't fit into any of the available categories."
        }
    }
}
