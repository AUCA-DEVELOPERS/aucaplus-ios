//
//  NewsItemViewModel.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 26/04/2023.
//

import Foundation

final class NewsItemViewModel: ObservableObject {
    @Published var item: News
    
    init(_ item: News) {
        self.item = item
    }
    
    func like() {
        item.like()
    }
    
    func dislike() {
        item.dislike()
    }
}
