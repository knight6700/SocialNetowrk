//
//  PrimaryTextField.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

/**
 A custom SwiftUI text field view with a primary styling.

 `PrimaryTextField` is designed to be used as a primary text input field in your SwiftUI user interface. It provides a stylized text field with customizable placeholder text and binding to text input.

 - Usage

 To use `PrimaryTextField`, initialize it with a binding to a `TextFildViewState`.

 ```swift
 @State private var usernameState = TextFildViewState(
     text: "",
     subtitle: "Enter your username",
     keyBoardType: .default,
     format: { $0 },
     validate: { _ in true },
     field: .username,
     identifier: "UsernameTextField"
 )

 var body: some View {
     PrimaryTextField(viewState: $usernameState)
 }
 */
public struct TextFildViewState {
    public var text: String
    public var isValid: Bool = false
    var tfFont: Font {
        .horizonFont(relativeTo: .callout, weight: .regular)
    }

    let tfColor: Color = .horizon(.blackColor)
    let subtitle: String
    let keyBoardType: UIKeyboardType
    var format: (String) -> String
    var validate: (String) -> Bool
    var field: Field
    var isSecure: Bool
    var identifier: String
    public enum Field {
        case username
        case password
    }

    public init(
        text: String,
        isValid: Bool = false,
        subtitle: String,
        keyBoardType: UIKeyboardType,
        format: @escaping (String) -> String,
        validate: @escaping (String) -> Bool,
        isSecure: Bool = false,
        field: TextFildViewState.Field,
        identifier: String
    ) {
        self.text = text
        self.isValid = isValid
        self.subtitle = subtitle
        self.keyBoardType = keyBoardType
        self.format = format
        self.validate = validate
        self.field = field
        self.isSecure = isSecure
        self.identifier = identifier
    }
}

public struct PrimaryTextField: View {
    @Binding var viewState: TextFildViewState
    @FocusState var focusState: TextFildViewState.Field?
    public init(
        viewState: Binding<TextFildViewState>
    ) {
        _viewState = viewState
    }

    public var body: some View {
        TextField(viewState.subtitle, text: $viewState.text)
            .font(viewState.tfFont)
            .foregroundColor(viewState.tfColor)
            .focused($focusState, equals: viewState.field)
            .onSubmit {
                focusState = nil
            }
            .keyboardType(viewState.keyBoardType)
            .disableAutocorrection(true)
            .accessibilityIdentifier(viewState.identifier)
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

struct PrimaryTextField_Previews: PreviewProvider {
    @State static var text: String = ""

    static var previews: some View {
        PrimaryTextField(viewState: .constant(.init(text: "", subtitle: "Enter Username", keyBoardType: .emailAddress, format: { $0 }, validate: { _ in true }, field: .username, identifier: "Primary")))
            .previewDisplayName("TextField")
    }
}
