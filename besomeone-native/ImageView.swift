//
//  ImageView.swift
//  besomeone-native
//
//  Created by Zaya Developer on 22/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    var data: Data?

    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data // 1) set data
                self.dataIsValid = true
            }
        }
        task.resume()
    }
}




struct ImageView: View, Equatable {
    static func == (lhs: ImageView, rhs: ImageView) -> Bool {
        let lhsImage = lhs.image
        let rhsImage = rhs.image
        if (lhsImage == nil && rhsImage != nil) || (lhsImage != nil && rhsImage == nil) {
            return false
        } else {
            return true
        } }



    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
    }

    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    var body: some View {
        HStack {
            Image(uiImage: self.imageLoader.dataIsValid ? self.imageFromData(self.imageLoader.data!) : UIImage())
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .clipped()
        }.frame(minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center

        )

    }
}


