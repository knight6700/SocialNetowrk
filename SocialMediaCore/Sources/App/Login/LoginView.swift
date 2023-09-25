//
//  LoginView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//

import SharedUI
import SwiftUI

public struct LoginView: View {
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: LoginViewModel
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image.horizon(LoginImages.loginPlaceHolder)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.45)
                        .clipped()
                    Text("Welcome")
                        .font(.horizonFont(relativeTo: .title3, weight: .bold))
                        .kerning(0.38)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.82))
                        .padding()

                    VStack(spacing: 24) {
                        usernameTextFieldView
                        passwordTextFieldView
                    }
                    .padding(.horizontal)

                    Spacer()
                    PrimaryButtonView(
                        title: "Login",
                        isDisable: viewModel.state.loginButtonDisable,
                        identifier: "loginButton",
                        action: {
                            viewModel.trigger(.loginButtonTapped)
                        }
                    )
                    .padding()
                }
                .frame(minHeight: geometry.size.height)
            }
            .frame(width: geometry.size.width)
            .scrollDisabled(true)
            .ignoresSafeArea()
            .showLoader(isLoading: $viewModel.state.isLoading)
            .onAppear {
                viewModel.trigger(.onAppear)
            }
        }
        .background(Color.clear)
    }
}

extension LoginView {
    var usernameTextFieldView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("User Name")
            PrimaryTextField(viewState: $viewModel.state.usernameFieldState)
        }
    }

    var passwordTextFieldView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Password")
            SecureTextFieldView(viewState: $viewModel.state.passwordFieldState)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(coordinator: .init(parent: .init())))
    }
}
