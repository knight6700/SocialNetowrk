//
//  CardView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//

import SharedUI
import SwiftUI

struct FBPost: View {
    @State var isLiked: Bool = false
    let model: FBPostModel

    var body: some View {
        VStack {
            HStack {
                Image.horizon(model.imageName)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(25)
                VStack {
                    HStack {
                        Text(model.name)
                            .font(.horizonFont(relativeTo: .callout, weight: .semibold))
                            .foregroundColor(Color.horizon(.blackColor))
                        Spacer()
                    }

                    HStack {
                        Text("12 minutes ago")
                            .foregroundColor(Color(.secondaryLabel))
                        Spacer()
                    }
                }
                Spacer()
            }

            Spacer()

            HStack {
                Text(model.body)
                    .font(.system(size: 24, weight: .regular, design: .default))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            if !model.photos.isEmpty {
                ImagesPostView(photos: model.photos)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            Spacer()
            Divider()
            HStack {
                Button {
                    isLiked.toggle()
                } label: {
                    HStack {
                        Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        Text(isLiked ? "Liked" : "Like")
                    }
                }
                Spacer()
                Button {
                } label: {
                    HStack {
                        Image(systemName: "message")
                        Text("Comment")
                    }
                }
                Spacer()
                Button {
                } label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                        Text("Share")
                    }
                }
            }
            .padding()
            .foregroundColor(.black)
        }

        .padding(.horizontal)
//        .background(Color(.systemBackground))
        .cornerRadius(7)
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        FBPost(model: [FBPostModel].posts.first!)
    }
}
