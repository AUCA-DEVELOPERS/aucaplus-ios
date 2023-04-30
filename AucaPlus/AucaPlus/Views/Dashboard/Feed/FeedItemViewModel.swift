//
//  FeedItemViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 24/04/2023.
//

import Foundation

final class FeedItemViewModel: ObservableObject {
    @Published var item: News
    
    init(item: News) {
        self.item = item
    }
    
    func like() {
        item.like()
    }
    
    func dislike() {
        item.dislike()
    }
}
