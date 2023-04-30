//
//  AppTabView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 02/04/2023.
//

import SwiftUI

struct AppTabView: View {
    @AppStorage(Storagekeys.appSelectedTab)
    private var selection: AppTab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
                .tag(AppTab.home)
            
            ChatsView()
                .tabItem {
                    Label("Chats", systemImage: "bubble.left.and.bubble.right")
                        .symbolVariant(SwiftUI.SymbolVariants.square)
                }
                .tag(AppTab.chats)
            
            JobsView()
                .tabItem {
                    Label("Opportunities", systemImage: "bag.circle")
                }
                .tag(AppTab.jobs)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(AppTab.settings)
        }
    }
    
    enum AppTab: String {
        case home, chats, jobs, settings
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
