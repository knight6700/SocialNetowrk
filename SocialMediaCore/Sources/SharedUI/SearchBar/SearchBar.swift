//
//  SearchBar.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI
/**
 A SwiftUI view representing a search bar with clear button functionality.

 `SearchBarView` is a custom view designed to provide a search input field with a clear button. It is used for searching within your SwiftUI user interface. The view includes a search icon, a text field for entering search queries, and a clear button that appears when the text field is focused.

 - Usage:

 To use `SearchBarView`, initialize it with a `SearchBarViewModel` instance that manages the search functionality.

 ```swift
 let searchBarViewModel = SearchBarViewModel()
 SearchBarView(viewModel: searchBarViewModel)
*/

public struct SearchBarView: View {
    @ObservedObject var viewModel: SearchBarViewModel
    @FocusState private var focusedField: Bool

    public init(viewModel: SearchBarViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.horizon(.whiteColor))
                HStack {
                    Image.horizon(NavigationImages.search)
                        .resizable()
                        .frame(width: 16, height: 16)
                    TextField(
                        "Search",
                        text: $viewModel.text
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($focusedField)
                    .onSubmit {
                        viewModel.trigger(.onSubmit)
                    }
                }
            }
            if focusedField {
                Button {
                    viewModel.trigger(.clear)

                } label: {
                    Image.horizon(NavigationImages.close)
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                }
                .transition(.move(edge: .leading))
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 0.81, green: 0.83, blue: 0.87), lineWidth: 1)
                .frame(height: 40)
        )
        .frame(height: 40)
        .padding(.horizontal, 25)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(viewModel: .init())
            .frame(height: 40)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
