//
//  OnboardingView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 31/03/2023.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("onboard-1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)

            Text("Powered by AUCA Devs")
                .fontDesign(.rounded)
                .foregroundColor(.accentColor)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
