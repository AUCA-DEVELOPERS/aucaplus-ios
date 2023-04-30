//
//  FeedBookmarksView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 24/04/2023.
//

import SwiftUI

struct FeedBookmarksView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 15) { item in
                Text("Bookmark Number \(item+1)!")
            }
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button("Clear All Bookmarks") {
                            
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}

struct FeedBookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        FeedBookmarksView()
    }
}
