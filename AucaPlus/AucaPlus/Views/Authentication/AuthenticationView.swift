//
//  AuthenticationView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 31/03/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var authVM = AuthenticationViewModel()
    
    enum FocusedField {
        case countryCode, phone
    }
    @State private var showingConfirmationAlert = false
    @State private var showingValidationAlert = false
    @State private var goToOTPView = false
    @FocusState private var focusedField: FocusedField?
    
    @AppStorage(Storagekeys.isLoggedIn)
    private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            TitleView(title: "Enter your phone number")
            
            VStack(spacing: 20) {
                Text("AUCA+ will need to verify your phone number.")
                    .multilineTextAlignment(.center)
                    .fixedSize()
                    .padding(.top)
                
                phoneFieldContainer
                
                Text("Carrier charges may apply")
                    .foregroundColor(.secondary)
            }
            .onSubmit(handleSubmission)
            
            VStack {
                Spacer()
                
                Button {
                    if authVM.authModel.isValid() {
                        showingConfirmationAlert.toggle()
                    } else {
                        showingValidationAlert.toggle()
                    }
                } label: {
                    Text("Next")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .alert("Please enter your phone number.",
                       isPresented: $showingValidationAlert,
                       actions: { })
                
            }
        }
        .padding(.horizontal, 25)
        .background(
            Color(.systemBackground)
                .onTapGesture {
                    focusedField = nil
                }
        )
        .alert("You entered the phone number:",
               isPresented: $showingConfirmationAlert,
               actions: {
            Button("Edit") { }
            Button("OK") {
                goToOTPView.toggle()
            }
        }, message: {
            Text("**\(authVM.authModel.formattedPhone())** \n Is this OK, or would you like to edit the number?")
        })
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: Delays.authFieldFocusTime) {
                focusedField = .phone
            }
        }
        .navigationDestination(isPresented: $goToOTPView) {
            OTPVerificationView(authVM: authVM)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("OK") {
                    focusedField = nil
                }
            }
        }
    }
}

private extension AuthenticationView {
    func handleSubmission() {
        focusedField = (focusedField == .countryCode) ? .phone : nil
    }
    
    var phoneFieldContainer: some View {
        HStack {
            HStack {
                Text("+")
                
                TextField("250", text: $authVM.authModel.countryCode)
                    .focused($focusedField, equals: .countryCode)
                    .frame(width: 40)
                    .keyboardType(.numberPad)
                    .disabled(true)
            }
            .padding(.bottom, 5)
            .overlay(alignment: .bottom) {
                Color.accentColor.frame(height: 1)
            }
            
            TextField("phone number", text: $authVM.authModel.phone)
                .focused($focusedField, equals: .phone)
                .keyboardType(.numberPad)
                .textContentType(.telephoneNumber)
                .padding(.bottom, 5)
                .overlay(alignment: .bottom) {
                    Color.accentColor.frame(height: 1)
                }
                .onChange(of: authVM.authModel.phone, perform: handlePhoneChange)
        }
        .padding(.horizontal, 40)
    }
    
    private func handlePhoneChange(_ newValue: String) {
        authVM.authModel.phone = String.formattedCDIPhoneNumber(from: newValue)
    }
}

extension AuthenticationView {
    struct TitleView: View {
        let title: String
        init(title: String) {
            self.title = title
        }
        var body: some View {
            Text(title)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    NavigationLink {
                        AuthHelpView()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .contentShape(Rectangle())
                    }
                }
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .padding(.vertical)
        }
    }
}

#if DEBUG
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
#endif


struct AuthHelpView: View {
    var body: some View  {
        Text("Show Helpful Message like how to's")
    }
}
