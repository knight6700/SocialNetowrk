//
//  ImagePostView.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 18/09/2023.
//
import SwiftUI
import SharedUI

struct ImagesPostView: View {
    var photos: [Photo]

    var homeGridItems: [GridItem] = [
        .init(.flexible()),
    ]
    var splitArray: [[Photo]] {
        var result: [[Photo]] = []
        guard photos.count > 1 else {
            result.append([photos[0]])
            return result
        }
        if photos.count == 2 {
            // If there are exactly two photos, split them into two separate arrays.
            result.append([photos[0]])
            result.append([photos[1]])
        } else {
            var currentSubarray: [Photo] = []

            for (index, photo) in photos.enumerated() {
                currentSubarray.append(photo)

                // If the current subarray reaches a count of 2 or it's the last photo,
                // add it to the result and reset the current subarray.
                if currentSubarray.count == 2 || index == photos.count - 1 {
                    result.append(currentSubarray)
                    currentSubarray = []
                }
            }
        }

        return result
    }

    var body: some View {
            HStack(alignment: .top) {
                if splitArray.count > 1 {
                    LazyVGrid(columns: homeGridItems) {
                        SecondLimitedImageList
                    }
                }
                LazyVGrid(columns: homeGridItems) {
                    limitedImageList
                }
        }
    }

    var limitedImageList: some View {
        let additionalImages = photos.count - 4

        return ForEach(splitArray[0], id: \.id) { index in
            if photos.count > 4 && index.id == splitArray[0].last?.id {
                ZStack {
                    asyncImageView(image: index.name, height: 170)
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame( height: 170)
                    .background(Color(red: 0.21, green: 0.25, blue: 0.33).opacity(0.7))
                    Text("+\(additionalImages)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(8)
                }
            } else {
                asyncImageView(image: index.name, height: 170)
            }
        }
    }

    var SecondLimitedImageList: some View {
        return ForEach(splitArray[1], id: \.id) { index in
            asyncImageView(image: index.name, height: photos.count == 3 ? 347 : 170)
        }
    }

    func asyncImageView(image: ImageProvider, height: CGFloat) -> some View {
        Image.horizon(image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .customFrame(isStatic: photos.count == 1, height: height)
        .clipped()

    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ImagesPostView(photos: .mockOnePhoto)
            .previewDisplayName("One")
        ImagesPostView(photos: .mockTwoPhotos)
            .previewDisplayName("Two")
        ImagesPostView(photos: .mockThreePhotos)
            .previewDisplayName("Three")
        ImagesPostView(photos: .mockFourPhotos)
            .previewDisplayName("Four")
        ImagesPostView(photos: .mockMoreThanFour)
            .previewDisplayName("MoreThanFour")
    }
}

