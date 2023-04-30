//
//  JobsViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation

final class JobsStore: ObservableObject {
    @Published var jobs: [Job] = Array(repeating: Job.example, count: 10)
}


struct Job: Codifiable {
    var id: String { UUID().uuidString }
    let title: String
    let company: Company
    let postedDate: Date
    
    let verified: Bool
}

extension Job {
    static let example = Job(title: "Investor Relations Intern",
                             company: .example,
                             postedDate: Date(),
                             verified: Bool.random())
}

struct Company: Codifiable {
    let id: Int
    let name: String
}

extension Company {
    static let example = Company(id: 1, name: "One Acre Fund")
}
