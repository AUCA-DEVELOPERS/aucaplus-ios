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
    
    @State private var overlay = OverlayModel<Announcement>()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 0) {
                        ForEach(feedStore.items, id: \.id) { item in
                            VStack(spacing: 3) {
                                if let announcement = item as? Announcement {
                                    AnnouncementRowView(announcement: announcement)
                                        .onTapGesture {
                                            withAnimation {
                                                overlay.present(announcement)
                                            }
                                        }
                                } else if let resource = item as? RemoteResource {
                                    ResourceRowView(resource: resource)
                                } else if let news = item as? News {
                                    NewsRowView(news)
                                }
                                
                                Divider()
                            }
                            .id(item.id)
                        }
                    }
                }
                
                if !feedStore.latestTweets.isEmpty {
                    
                    VStack(alignment: .leading) {
                        Text("Latest Tweeks")
                            .font(.title2.weight(.bold))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(feedStore.latestTweets) { tweet in
                                    VStack(alignment: .leading) {
                                        Text(tweet.text)
                                            .lineLimit(3)
                                        
                                        Text(tweet.createdDate.formatted(date: .long, time: .shortened))
                                            .opacity(0.8)
                                    }
                                    .padding(10)
                                    .frame(maxWidth: UIScreen.main.bounds.width*0.9, alignment: .leading)
                                    .frame(height: 200)
                                    .background(.regularMaterial)
                                    .cornerRadius(10)
                                }
                                
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $goToCreator) {
                PostCreatorView()
                    .environmentObject(feedStore)
            }
            .overlayListener(of: $overlay) { announcement in
               AnnouncementRowView(announcement: announcement, isExpanded: true)
                    .padding()
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
            ForEach(FeedStore.FeedFilter.allCases, id:\.self) { filter in
                Button {
                    feedStore.setFilter(filter)
                } label: {
                    Label {
                        Text(filter.rawValue.capitalized)
                    } icon: {
                        if filter == feedStore.filter {
                            Image(systemName: "checkmark")
                        } else {
                            Image(uiImage: .init())
                        }
                    }

//                    Label(item.rawValue.capitalized, image: String)
//                    Label(item.rawValue.capitalized, ima: "checkmark.seal.fill")
                    
                    
                }
            }
            
//            Button {
//
//            } label: {
//                Label("Verified", systemImage: "checkmark.seal.fill")
//            }
           
//            Button {
//
//            } label: {
//                Label("For Me", systemImage: "person.badge.shield.checkmark.fill")
//            }
            
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


struct OverlayModel<T>: Identifiable {
    var id: UUID { .init() }
    
    var isShown: Bool = false
    
    var data: T?
    
    mutating func present(_ newData: T) {
        data = newData
        isShown = true
    }
    
    mutating func dismiss() {
        isShown = false
        data = nil
    }
}

extension View {
    func overlayListener<Content, T>(
        of overlay: Binding<OverlayModel<T>>,
        @ViewBuilder content: (T) -> Content)
    -> some View where Content: View {
        self
            .overlay {
                ZStack {
                        Color.black.opacity(0)
                            .ignoresSafeArea()
                            .background(.ultraThinMaterial.opacity(overlay.wrappedValue.isShown ? 1 :0))
                            .onTapGesture {
                                overlay.wrappedValue.dismiss()
                            }
                    
                    if let data = overlay.wrappedValue.data {
                        content(data)
                            
                    }
                }
            }
    }
}
