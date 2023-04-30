//
//  AuthInfoView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 30/04/2023.
//

import SwiftUI

struct AuthInfoView: View {
    @ObservedObject var authVM: AuthenticationViewModel
    
    enum FocusedField {
        case firstName, lastName
        case email, about
    }
    @State private var showingValidationAlert = false
    @FocusState private var focusedField: FocusedField?
    @State private var userModel = UIModel()
    
    @AppStorage("isLoggedIn")
    private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            AuthenticationView.TitleView(title: "Almost there!")

            VStack(spacing: 20) {
                Text("Fill in the form below to get in!")
                    .multilineTextAlignment(.center)
                    .fixedSize()
                    .padding(.vertical)

                HStack(spacing: 15) {

                    ZFieldStack("First Name", text: $userModel.firstName)
                        .textContentType(.givenName)
                        .focused($focusedField, equals: .firstName)

                    ZFieldStack("Last Name", text: $userModel.lastName)
                        .textContentType(.familyName)
                        .focused($focusedField, equals: .lastName)
                }
                .submitLabel(.next)

                ZFieldStack("Email(Optional)", text: $userModel.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)

                ZFieldStack("Headline(Optional)",
                            axis: .vertical(lines: 5),
                            text: $userModel.about)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .focused($focusedField, equals: .about)
                    .submitLabel(.next)

                VStack(alignment: .leading) {
                    HStack {
                        Text("Choose Account Type:")
                        Spacer()
                        Picker("",
                               selection: $userModel.type) {
                            ForEach(AucaUserType.allCases, id: \.self) { type in
                                Text(type.rawValue.capitalized)
                            }
                        }
                               .pickerStyle(.menu)
                               .background(.regularMaterial)
                               .cornerRadius(5)

                    }
                    Text(userModel.type.description)
                        .font(.caption)
                        .fontDesign(.rounded)
                        .foregroundColor(.secondary)
                }
            }
            .onSubmit(handleSubmission)

            VStack {
                Spacer()

                Button {
                    isLoggedIn = true
                } label: {
                    Text("Finish")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
        }
        .padding(.horizontal, 25)
        .toolbar(.hidden)
        .background(
            Color(.systemBackground)
                .onTapGesture {
                    focusedField = nil
                }
        )
        .alert("You entered the phone number:",
               isPresented: $showingValidationAlert,
               actions: {
            Button("Cancel", role: .cancel) { }
            Button("OK") {
                
            }
        }, message: {
            Text("**\(authVM.authModel.formattedPhone())** \n Is this OK, or would you like to edit the number?")
        })
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("OK") {
                    focusedField = nil
                }
            }
        }
    }
}

private extension AuthInfoView {
    func handleSubmission() {
        switch focusedField {
        case .firstName:
            focusedField = .lastName
        case .lastName:
            focusedField = .email
        case .email:
            focusedField = .about
        case .about:
            focusedField = nil
        case .none: break;
        }
    }
    
    private func handlePhoneChange(_ newValue: String) {
        authVM.authModel.phone = String.formattedCDIPhoneNumber(from: newValue)
    }
    
    struct UIModel {
        var firstName = ""
        var lastName = ""
        var type = AucaUserType.student
        var email = ""
        var about = ""
    }
}

#if DEBUG
struct AuthInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AuthInfoView(authVM: AuthenticationViewModel())
    }
}
#endif

struct ZFieldStack: View {
    private let title: LocalizedStringKey
    private let placeholder: LocalizedStringKey
    private let axis: Axis
    @Binding var text: String
    
    enum Axis {
        case horizontal
        case vertical(maxHeight: CGFloat? = nil, lines: Int? = nil)
    }
    
    init(_ title: LocalizedStringKey,
         _ placeholder: LocalizedStringKey = "",
         axis: Axis = .horizontal,
         text: Binding<String>) {
        
        self.title = title
        self.placeholder = placeholder
        self.axis = axis
        self._text = text
    }
    
    
    @ViewBuilder
    var fieldView: some View {
        switch axis {
        case .horizontal:
            TextField("", text: $text)
                .padding(10)
                .frame(height: 45 )
        case .vertical(let maxHeight, let lines):
            TextField("", text: $text, axis: .vertical)
                .padding(10)
                .frame(minHeight: 45, maxHeight: maxHeight)
                .lineLimit(lines)
        }
    }
    
    var body: some View {
        VStack {
            fieldView
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1)
                })
                .overlay(alignment: .topLeading) {
                    Text(title)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .background(.background)
                        .offset(x: 0, y: -8)
                }
        }
    }
}
