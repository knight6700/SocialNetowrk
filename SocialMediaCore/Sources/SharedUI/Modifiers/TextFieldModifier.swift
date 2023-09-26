//
//  TextFieldModifier.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

/**
  A SwiftUI modifier for enhancing the styling of text fields with an optional secure entry button.

  `CustomTextFieldModifier` can be applied to SwiftUI text fields to provide consistent styling and the option to include a secure entry button. It improves the visual appearance of text fields by adding padding, a rounded background, and a subtle shadow.

  - Usage:

  To apply this modifier to a text field, use the `.modifier` modifier and provide an instance of `CustomTextFieldModifier`. You can also enable the secure entry mode by setting `showSecureButton` to `true`.

  ```swift
  TextField("Password", text: $password)
      .customTextFieldStyle(showSecureButton: true)
*/

public struct CustomTextFieldModifier: ViewModifier {
    @Binding var isSecure: Bool
    var showSecureButton: Bool = false

    public func body(content: Content) -> some View {
        HStack {
            content
            if showSecureButton {
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image.horizon(isSecure ? .eyeFill : .eyeSlashFill)
                        .imageScale(.small)
                        .font(.title3)
                        .foregroundColor(.horizon(.darkGray))
                        .padding(.horizontal)
                }
                .accessibilityIdentifier("hideSecureButton")
                .foregroundColor(.horizon(.grayColor))
            }
        }

    }
}

public extension View {
    func customTextFieldStyle(
        isSecure: Binding<Bool> = .constant(false),
        showSecureButton: Bool
    ) -> some View {
        modifier(
            CustomTextFieldModifier(
                isSecure: isSecure,
                showSecureButton: showSecureButton
            )
        )
    }
}


struct ValidationView: ViewModifier {
    var isFocused: Bool
    var isValid: Bool
    var isEmptyText: Bool
    var color: Color {
        (isValid && !isFocused) ?
            Color.horizon(.tFBoderColor).opacity(0.8) :
            isFocused ?
            Color.horizon(.blackColor) :
            (!isValid && !isEmptyText) ?
            Color.horizon(.redLightColor) :
            Color.horizon(.tFBoderColor).opacity(0.20)
    }

    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
                    .foregroundColor(color)
            )
    }
}

extension View {
    func cardValidation(
        isFocused: Bool,
        isValid: Bool,
        isEmptyText: Bool
    ) -> some View {
        modifier(ValidationView(isFocused: isFocused, isValid: isValid, isEmptyText: isEmptyText))
    }
}
