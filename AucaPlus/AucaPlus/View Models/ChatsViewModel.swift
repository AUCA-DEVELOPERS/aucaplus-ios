//
//  ChatsViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 15/04/2023.
//

import Foundation

final class ChatsViewModel: ObservableObject {
    @Published var chats: [Chat] = []
}

struct Chat {
    let id: UUID
}
