//
//  FeedView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 02/04/2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var feedStore = FeedStore()
    @State private var goToCreator = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 0) {
                        ForEach(feedStore.news) { newsItem in
                            VStack(spacing: 3) {
                                FeedRowView(itemVM: .init(item: newsItem))
                                Divider()
                            }
                            .id(newsItem.id)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $goToCreator) {
                PostCreatorView()
            }
            .navigationBarTitle("Feed")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    filterMenu
                    
                    addButton
                }
            }
        }
    }
    
    private var filterMenu: some View {
        Menu {
            Button {
                
            } label: {
                Label("Verified", systemImage: "checkmark.seal.fill")
            }
            
            Button {
                
            } label: {
                Label("For Me", systemImage: "person.badge.shield.checkmark.fill")
            }
            
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
    }
    
    private var addButton: some View {
        Button {
            goToCreator.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
}

#if DEBUG
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .previewLayout(SwiftUI.PreviewLayout.fixed(width: 416, height: 1000))
    }
}
#endif
