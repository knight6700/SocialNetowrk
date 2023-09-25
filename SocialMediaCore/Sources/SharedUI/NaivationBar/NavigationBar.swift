//
//  NavigationBar.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

public enum NavPresentationStyle {
  case modal
  case navigation
}

 extension View {
     /**
          Applies a custom navigation bar style to the view.

          This function allows you to customize the appearance of the navigation bar, including its background color, foreground color, title, navigation presentation style, trailing view, and dismissal action.

          - Parameters:
             - backgroundColor: The background color of the navigation bar. Defaults to `.horizon(.whiteColor)`.
             - foregroundColor: The foreground color of text and icons in the navigation bar. Defaults to `.horizon(.grayColor)`.
             - title: The view representing the title displayed in the navigation bar.
             - navPresentationStyle: The navigation presentation style, either `.modal` or `.navigation`. Defaults to `.navigation`.
             - trailing: The view to be displayed on the trailing side of the navigation bar. Defaults to an empty view.
             - onDismiss: A closure to be executed when the navigation view is dismissed. Defaults to an empty closure.

          - Returns: A modified view with the specified custom navigation bar style.
          */
  public func navigationStyle<Title: View, Trailing: View>(
    backgroundColor: Color = .horizon(.whiteColor),
    foregroundColor: Color = .horizon(.grayColor),
    title: Title,
    navPresentationStyle: NavPresentationStyle = .navigation,
    trailing: Trailing,
    onDismiss: @escaping () -> Void = {}
  ) -> some View {
    NavigationBar(
      backgroundColor: backgroundColor,
      content: self,
      foregroundColor: foregroundColor,
      navPresentationStyle: navPresentationStyle,
      onDismiss: onDismiss,
      title: title,
      trailing: trailing
    )
  }
     /**
          Applies a custom navigation bar style to the view with default settings for trailing view.

          This function allows you to customize the appearance of the navigation bar, including its background color, foreground color, title, navigation presentation style, and dismissal action. It uses default settings for the trailing view, which is an empty view.

          - Parameters:
             - backgroundColor: The background color of the navigation bar. Defaults to `.horizon(.whiteColor)`.
             - foregroundColor: The foreground color of text and icons in the navigation bar. Defaults to `.horizon(.grayColor)`.
             - title: The view representing the title displayed in the navigation bar.
             - navPresentationStyle: The navigation presentation style, either `.modal` or `.navigation`. Defaults to `.navigation`.
             - onDismiss: A closure to be executed when the navigation view is dismissed. Defaults to an empty closure.

          - Returns: A modified view with the specified custom navigation bar style.
          */
  public func navigationStyle<Title: View>(
    backgroundColor: Color = .horizon(.whiteColor),
    foregroundColor: Color = .horizon(.grayColor),
    title: Title,
    navPresentationStyle: NavPresentationStyle = .navigation,
    onDismiss: @escaping () -> Void = {}
  ) -> some View {
    self.navigationStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      title: title,
      navPresentationStyle: navPresentationStyle,
      trailing: EmptyView(),
      onDismiss: onDismiss
    )
  }
}

/**
 A private SwiftUI view struct that implements a custom navigation bar.

 `NavigationBar` is used internally to create a custom navigation bar appearance for views with the `navigationStyle` modifier. It provides customizable background and foreground colors, title, navigation presentation style, trailing view, and dismissal action.

 - Warning: This struct is an implementation detail and should not be used directly in your code.

 - Implementation Details
 The `NavigationBar` struct contains the core logic for creating a custom navigation bar appearance. It is responsible for laying out the navigation bar's elements, including the title, trailing view, and back button (if applicable).

 - SeeAlso
 
    `View.navigationStyle(backgroundColor:foregroundColor:title:navPresentationStyle:trailing:onDismiss:)`
 - Parameters
    - `Title`: A SwiftUI `View` type representing the title view in the navigation bar.
    - `Content`: A SwiftUI `View` type representing the content of the view associated with the navigation bar.
    - `Trailing`: A SwiftUI `View` type representing the trailing view displayed in the navigation bar.

 - Note:
    - This struct is designed for internal use to provide a consistent and customizable navigation bar style for views.

 - Important:
    - Do not use this struct directly in your SwiftUI code. Instead, use the `navigationStyle` modifier to apply the custom navigation bar style to your views.
 */
private struct NavigationBar<Title: View, Content: View, Trailing: View>: View {
  let backgroundColor: Color
  let content: Content
  let foregroundColor: Color
  let navPresentationStyle: NavPresentationStyle
  let onDismiss: () -> Void
  @Environment(\.presentationMode) @Binding var presentationMode
  let title: Title
  let trailing: Trailing

  var body: some View {
    VStack {
      ZStack {
        self.title
        HStack {
          if self.navPresentationStyle == .navigation {
            Button(action: self.dismiss) {
              Image(systemName: "arrow.left")
            }
          }
          Spacer()
            self.trailing
        }
      }
      .padding()
        Divider()
      self.content
    }
    .background(self.backgroundColor.ignoresSafeArea())
    .foregroundColor(self.foregroundColor)
    .navigationBarHidden(true)
  }

  func dismiss() {
    self.onDismiss()
    self.presentationMode.dismiss()
  }
}
