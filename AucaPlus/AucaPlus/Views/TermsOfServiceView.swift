//
//  TermsOfServiceView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 31/03/2023.
//

import SwiftUI

struct TermsOfServiceView: View {
    @State private var logoCoclor: Color = .clear
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("auca.logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.accentColor)
                .scaledToFit()
                .padding(30)
                .frame(maxHeight: 380)
            
            VStack(spacing: 20) {
                Text("Welcome to AUCA+")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Read our \(Text("Privacy Policy").foregroundColor(.accentColor)). Tap \"Agree and\ncontinue to acceppt the \(Text("Terms of Service").foregroundColor(.accentColor))")
                    .multilineTextAlignment(.center)
                    .overlay(alignment: .bottom) {
                        Button {
                            
                        } label: {
                            Text("Agree and continue")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                        }
                        
                        .buttonBorderShape(.capsule)
                        .buttonStyle(.borderedProminent)
                        .offset(y: 70)
                    }
            }
            .padding()
            
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
