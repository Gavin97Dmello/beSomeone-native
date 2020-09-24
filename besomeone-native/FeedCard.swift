

import SwiftUI
import Pages
import URLImage
import ActiveLabel

struct FeedCard: View {
    @State var feedCardData: Feed
    @State var index = 0
    @State var currentPage = 0
    @Binding var hideStatusBar: Bool

    func getDescription() -> ActiveLabel {
        let label = ActiveLabel()
        label.numberOfLines = 4
        label.enabledTypes = [.mention, .hashtag, .url]
        label.text = self.feedCardData.description
        label.textColor = .black


        return label;
    }

    var body: some View {
        VStack {
            VStack {
                VStack {
                    if self.feedCardData.images_details.count > 1 {



                        ModelPages(self.feedCardData.images_details, currentPage: self.$index, hasControl: false) { i, image in
//                            NavigationView{
//                            NavigationLink(destination: FeedDetailView(feedDetails: self.$feedCardData, statusBar: self.$hideStatusBar)) {
                            ImageView(withURL: image.path)
//                            }
//                            }
                        }.aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))



                        self.feedCardData.images_details.count == 1 ? nil : PageControl(index: $index, maxIndex: self.feedCardData.images_details.count - 1, selected: Color.blue, unSelected: Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255, opacity: 0.2))
                            .padding()
                            .frame(height: 10.0).padding(.all, 0);
                    }
                    else if self.feedCardData.images_details.count == 1 {
                        ImageView(withURL: feedCardData.images_details[0].path).aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))
                    }

                    (self.feedCardData.images_details.count == 0 && self.feedCardData.subjects_details.count == 0) ?
                    Image("default")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        : nil;
                    (self.feedCardData.images_details.count == 0 && self.feedCardData.subjects_details.count > 0) ?
                    ImageView(withURL: feedCardData.subjects_details[0].attachment_details.path).aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))
                        : nil;
                    HStack {
                        Text(self.feedCardData.title).modifier(BoldTitle()).lineLimit(2)
                        Spacer()
                    }.padding(.top, self.feedCardData.images_details.count > 1 ? 2 : 10)
                    HStack {
                        Spacer()

                        Button(action: {

                            
                        }) {
                            Image("moreOptions").resizable()
                                .frame(width: 15.0, height: 15.0)
                        }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)

                    }
                    HStack {

                        Text(self.feedCardData.description)
                            .modifier(RegularText()).lineLimit(4)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        ZStack {

                            Text("See more").modifier(FadedBoldSubText())
                            NavigationLink(destination:
                                    FeedDetailView(feedDetails: self.$feedCardData, statusBar: $hideStatusBar)) {
                                EmptyView()
                            }.frame(width: 0, height: 0)
                                .hidden()


                        }


                    }
                    HStack {
                        HStack {
                            Image("like_grey").resizable().frame(width: 20.0, height: 20.0).padding(.bottom, 3)
                            Text("\(String(self.feedCardData.is_interested == true ? self.feedCardData.interested_count + 1: self.feedCardData.interested_count))").modifier(FadedRegularText())
                        }
                        Spacer()
                        HStack {
                            Image("comment_grey").resizable().frame(width: 20.0, height: 20.0)
                            Text("\(String(self.feedCardData.comments_count))").modifier(FadedRegularText())
                        }
                        Spacer()
                        HStack {
                            Image("share_grey").resizable().frame(width: 20.0, height: 20.0)
                            Text("\(String(self.feedCardData.share_count))").modifier(FadedRegularText())
                        }
                        Spacer()
                        HStack {
                            Text("\(String(self.feedCardData.interested_count_from_school))").modifier(FadedRegularText()).font(.custom("SFProText-Regular", size: 10))
                            Image("likeBlue").resizable().frame(width: 16.0, height: 16.0).padding(.bottom, 2)
                            Text("in your school").modifier(FadedRegularText()).font(.custom("SFProText-Regular", size: 10))
                        }
                    }
                }
                Divider()
                HStack {
                    Button(action: { self.feedCardData.is_interested = !self.feedCardData.is_interested; }) {
                        Image(self.feedCardData.is_interested == false ? "like_black" : "likeBlue")
                            .renderingMode(.original).resizable().frame(width: 30.0, height: 30.0).padding(.bottom, 5)
                        Text("Interested").modifier(BoldText())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)
                    Spacer()
                    Button(action: { print("Working button") }) {
                        Image("comment_black").renderingMode(.original).resizable().frame(width: 30.0, height: 30.0)
                        Text("Comment").modifier(BoldText())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)
                    Spacer()
                    Button(action: { print("Working button") }) {
                        Image("share_black").renderingMode(.original).resizable().frame(width: 30.0, height: 30.0)
                        Text("Share").modifier(BoldText())
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
            feedCardData: Feed(
                id: "", title: "", description: "", interested_count: 0, comments_count: 0, share_count: 0, interested_count_from_school: 0, is_interested: false, images_details: [ImageDetails(path: "")], subjects_details: [SubjectImages(attachment_details: AttachmentDetails(path: ""), title: "")], link_details: [LinkDetails(url: "")], skills_marked: [SkillsMarked(id: "", title: "", marked: 0)]),
            hideStatusBar: Binding.constant(false)
//            title: Binding.constant("Title"),
//            description: Binding.constant("Description"),
//            interested_count: Binding.constant(0),
//            comments_count: Binding.constant(0),
//            share_count: Binding.constant(0),
//            interested_count_from_school: Binding.constant(0),
//            is_interested: Binding.constant(false),
//            images_details: Binding.constant([ImageDetails(path: "")]),
//            subjects_details: Binding.constant([SubjectImages(attachment_details: AttachmentDetails(path: ""))])
        )
    }
}

