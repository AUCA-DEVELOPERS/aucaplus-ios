//
//  ContentView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 31/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var animatingOnBoarding = true
    @State private var showingOnBoarding = true
    
    @AppStorage("isLoggedIn")
    private var isLoggedIn: Bool = false
        
    var body: some View {
        if isLoggedIn {
            AppTabView()
        } else {
            NavigationStack {
                ZStack {
                    AuthenticationView()
                    
                    if showingOnBoarding {
                        OnboardingView()
                            .opacity(animatingOnBoarding ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5), value: animatingOnBoarding)
                            .onAppear() {
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                                    animatingOnBoarding = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.3) {
                                    showingOnBoarding = false
                                }
                            }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
