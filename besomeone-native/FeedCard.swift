//
//  FeedCard.swift
//  besomeone-native
//
//  Created by Zaya Developer on 11/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI
import Pages
import URLImage

struct FeedCard: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var interested_count: Int
    @Binding var comments_count: Int
    @Binding var share_count: Int
    @Binding var interested_count_from_school: Int
    @Binding var is_interested: Bool
    @Binding var image_details: [ImageDetails]
    @Binding var subject_details: [SubjectImages]
    @State var index = 0

    @State var currentPage = 0


    var body: some View {

        VStack {
            VStack {
                VStack {


//                    self.image_details.count > 1 ?
////                        ImageCarouselView(numberOfImages: self.image_details.count) {
////
////                            ForEach( self.image_details) { value in
////                                ImageView(withURL:value.path)
////                            }
////                        }
////
////                    PagingView(index: $index.animation(), maxIndex: self.image_details.count - 1) {
//                    Pages(currentPage: $currentPage, pages: {
//                        ForEach(self.image_details) { imageName in
//                            ImageView2(withURL: imageName.path)
//                        }
//                        ForEach(self.image_details) { imageName in
//                            ImageView2(withURL: imageName.path)
//                        }
//                    })
//
////                    }.aspectRatio(1 / 1.05, contentMode: .fill)

//                    : nil



//                    VStack {
                    if self.image_details.count > 0 {

                        ModelPages(self.image_details, currentPage: self.$index, hasControl: false) { i, image in
//                            VStack {
//
//                                Text(image.path)
//                                URLImage(URL(string: image.path)!)
                            ImageView2(withURL: image.path)
//                            }
                        }.aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))


                        self.image_details.count == 1 ? nil : PageControl(index: $index, maxIndex: self.image_details.count - 1)
                            .padding()
                            .frame(height: 10.0).padding(.all, 0);

//                            }
//                        }
//                        else if (self.image_details.count == 2) {
////                            GeometryReader { geometry in
//
//                            Pages(currentPage: self.$currentPage, pages: {
//                                ImageView2(withURL: self.image_details[0].path)
//                                ImageView2(withURL: self.image_details[1].path)
//                            }).aspectRatio(1 / 1, contentMode: .fit)
////                                    .frame(height: geometry.size.width)
//
////                            }
//
//                        }
//                        else if (self.image_details.count == 3) {
//
//                            Pages(currentPage: $currentPage, pages: {
//                                ImageView2(withURL: self.image_details[0].path)
//                                ImageView2(withURL: self.image_details[1].path)
//                                ImageView2(withURL: self.image_details[2].path)
//                            }).aspectRatio(1 / 1, contentMode: .fit)
//
//                        }
//                        else if (self.image_details.count == 4) {
//
//                            Pages(currentPage: $currentPage, pages: {
//                                ImageView2(withURL: self.image_details[0].path)
//                                ImageView2(withURL: self.image_details[1].path)
//                                ImageView2(withURL: self.image_details[2].path)
//                                ImageView2(withURL: self.image_details[3].path)
//                            }).aspectRatio(1 / 1, contentMode: .fit)
//
//                        }
//                        else if (self.image_details.count == 5) {
//
//                            Pages(currentPage: $currentPage, pages: {
//                                ImageView2(withURL: self.image_details[0].path)
//                                ImageView2(withURL: self.image_details[1].path)
//                                ImageView2(withURL: self.image_details[2].path)
//                                ImageView2(withURL: self.image_details[3].path)
//                                ImageView2(withURL: self.image_details[4].path)
//                            }).aspectRatio(1 / 1, contentMode: .fit)
//
//                        }

                    }


                    (self.image_details.count == 0 && self.subject_details.count == 0) ?
                    Image("default")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        : nil;

                    (self.image_details.count == 0 && self.subject_details.count > 0) ?
                    ImageView2(withURL: subject_details[0].attachment_details.path).aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))
                        : nil;


                    HStack {
                        Text(self.title).modifier(BoldTitle()).lineLimit(2)
                        Spacer()
                    }.padding(.top, self.image_details.count > 1 ? 2 : 10)
                    HStack {
                        Spacer()
                        Button(action: { print("Working button") }) {
                            Image("moreOptions").resizable()
                                .frame(width: 15.0, height: 15.0)
                        }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)
                    }
                    HStack {
                        Text(self.description)
                            .modifier(RegularText()).lineLimit(4)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action: { print("Working button") }) {
                            Text("Show more").modifier(FadedBoldText())
                        }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)
                    }
                    HStack {
                        HStack {
                            Image("like_grey").resizable().frame(width: 20.0, height: 20.0).padding(.bottom, 3)
                            Text("\(String(self.is_interested == true ? self.interested_count + 1: self.interested_count))").modifier(FadedRegularText())
                        }
                        Spacer()
                        HStack {
                            Image("comment_grey").resizable().frame(width: 20.0, height: 20.0)
                            Text("\(String(self.comments_count))").modifier(FadedRegularText())
                        }
                        Spacer()
                        HStack {
                            Image("share_grey").resizable().frame(width: 20.0, height: 20.0)
                            Text("\(String(self.share_count))").modifier(FadedRegularText())

                        }
                        Spacer()
                        HStack {
                            Text("\(String(self.interested_count_from_school))").modifier(FadedRegularText()).font(.custom("SFProText-Regular", size: 10))

                            Image("likeBlue").resizable().frame(width: 16.0, height: 16.0).padding(.bottom, 2)
                            Text("in your school").modifier(FadedRegularText()).font(.custom("SFProText-Regular", size: 10))
                        }

                    }

                }
                Divider()
                HStack {
                    Button(action: { self.is_interested = !self.is_interested; }) {
                        Image(self.is_interested == false ? "like_black" : "likeBlue")
                            .renderingMode(.original).resizable().frame(width: 30.0, height: 30.0).padding(.bottom, 5)
                        Text("Interested").modifier(BoldTitle())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)


                    Spacer()
                    Button(action: { print("Working button") }) {
                        Image("comment_black").renderingMode(.original).resizable().frame(width: 30.0, height: 30.0)
                        Text("Comment").modifier(BoldTitle())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)
                    Spacer()
                    Button(action: { print("Working button") }) {
                        Image("share_black").renderingMode(.original).resizable().frame(width: 30.0, height: 30.0)
                        Text("Share").modifier(BoldTitle())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)


                }.padding(.top, 5.0)

            }.padding([.top, .leading, .trailing], 15.0)
            GeometryReader { geometry in
                Text("")
                    .padding()
                    .frame(width: geometry.size.width, height: 4.0)
                    .background(Color(red: 216 / 255, green: 216 / 255, blue: 216 / 255, opacity: 1.0))

            }.frame(height: 4)

        }

    }
}

struct FeedCard_Previews: PreviewProvider {
    static var previews: some View {
        FeedCard(
            feedCardData:
//            title: Binding.constant("Title"),
//            description: Binding.constant("Description"),
//            interested_count: Binding.constant(0),
//            comments_count: Binding.constant(0),
//            share_count: Binding.constant(0),
//            interested_count_from_school: Binding.constant(0),
//            is_interested: Binding.constant(false),
//            image_details: Binding.constant([ImageDetails(path: "")]),
//            subject_details: Binding.constant([SubjectImages(attachment_details: AttachmentDetails(path: ""))])
        )
    }
}


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

// ImageView

struct ImageView: View {
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
            Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
                .resizable()
                .scaledToFit()
                .clipped()

        }
    }
}


struct ImageView2: View, Equatable{
    static func == (lhs: ImageView2, rhs: ImageView2) -> Bool {
        let lhsImage = lhs.image
                  let rhsImage = rhs.image
                  if (lhsImage == nil && rhsImage != nil) || (lhsImage != nil && rhsImage == nil) {
                      return false
                  } else {
                      return true
                  }    }
    
    
    
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

