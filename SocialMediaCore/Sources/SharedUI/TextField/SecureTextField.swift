//
//  SecureTextField.swift
//
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI
/**
 A custom SwiftUI view that provides a secure text input field with an optional toggle for password visibility.

 `SecureTextFieldView` is designed for secure text input, such as passwords, in your SwiftUI user interface. It allows users to toggle between hidden and visible password text for enhanced usability and security.

 - Usage
 
 To use `SecureTextFieldView`, initialize it with a binding to a `TextFildViewState`.

 ```swift
 @State private var passwordState = TextFildViewState(
     text: "",
     subtitle: "Enter your password",
     keyBoardType: .default,
     format: { $0 },
     validate: { _ in true },
     isSecure: true, // Set to `true` for password fields
     field: .password, // Use `.password` for password fields
     identifier: "PasswordTextField"
 )

 var body: some View {
     SecureTextFieldView(viewState: $passwordState)
 }
 */
public struct SecureTextFieldView: View {
    @Binding var viewState: TextFildViewState
    @FocusState var focusState: TextFildViewState.Field?
    public init(
        viewState: Binding<TextFildViewState>
    ) {
        _viewState = viewState
    }

    public var body: some View {
        ZStack {
            if viewState.isSecure {
                SecureField("Enter your password", text: $viewState.text)
                    .accessibilityIdentifier(viewState.identifier)
            } else {
                TextField("Enter your password", text: $viewState.text)
                    .accessibilityIdentifier("passwordNotSecure")
            }
        }
        .customTextFieldStyle(isSecure: $viewState.isSecure,showSecureButton: true)
        .font(viewState.tfFont)
        .foregroundColor(viewState.tfColor)
        .focused($focusState, equals: viewState.field)
        .onSubmit {
            focusState = nil
        }
        .keyboardType(viewState.keyBoardType)
        .disableAutocorrection(true)
        .cardValidation(
            isFocused: focusState != nil,
            isValid: viewState.isValid,
            isEmptyText: viewState.text.isEmpty
        )
        .onChange(
            of: viewState.text
        ) { newValue in
            viewState.text = viewState.format(newValue)
            viewState.isValid = viewState.validate(viewState.text)
        }
        .onAppear {
            focusState = .username
        }

    }
}

struct SecureTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextFieldView(viewState: .constant(.init(text: "", subtitle: "Enter Password", keyBoardType: .emailAddress, format: { $0 }, validate: { _ in true }, field: .username, identifier: "")))
    }
}
