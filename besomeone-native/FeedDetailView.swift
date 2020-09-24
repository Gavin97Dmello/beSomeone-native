//
//  FeedDetailView.swift
//  besomeone-native
//
//  Created by Zaya Developer on 22/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI
import Pages


struct FeedDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var settings: UserSettings


    @Binding var feedDetails: Feed
    @State var index = 0
    @State var currentPage = 0
    @State var isInProgress = false
    @State var isDone = false
    @State var canGuide = false
    
    @State var skillMarked1: [SkillsMarked] = []
    @State var skillMarked2: [SkillsMarked] = []
    @State var didSeeMore: Bool = false

//    init() {
//        self.getMarkedSkills();
//    }
//    private var subjectList: String = "NA"

    func getMarkedSkills() {
        if (self.feedDetails.skills_marked.count > 0) {
            var skills1: [SkillsMarked] = [];
            var skills2: [SkillsMarked] = [];
            if(self.feedDetails.skills_marked.count > 10) {
                for i in 0...9 {
                    skills1.append(self.feedDetails.skills_marked[i])
                }
                for j in 10...self.feedDetails.skills_marked.count - 1 {
                    skills2.append(self.feedDetails.skills_marked[j])
                }
            }
            else {
                for k in 0...self.feedDetails.skills_marked.count - 1 {
                    skills1.append(self.feedDetails.skills_marked[k])
                }
                skills2 = []
            }
            self.skillMarked1 = skills1;
            self.skillMarked2 = skills2;

        }
    }



    func getSubjects() -> Text {
        var subjectList: String = ""
        if(self.feedDetails.subjects_details.count > 0) {
            for i in 0...self.feedDetails.subjects_details.count - 1 {
                if(i == self.feedDetails.subjects_details.count - 1) {
                    subjectList += "\(self.feedDetails.subjects_details[i].title)";
                }
                else {
                    subjectList += "\(self.feedDetails.subjects_details[i].title), ";
                }
            }

            return Text(subjectList);
        }
        else {
            return Text("NA");
        }
    }

    func getLinks() -> ModifiedContent<Text, RegularLinkText> {
        var subjectList: String = ""
        if(self.feedDetails.link_details.count > 0) {
            for i in 0...self.feedDetails.link_details.count - 1 {
                if(i == self.feedDetails.link_details.count - 1) {
                    subjectList += "\(self.feedDetails.link_details[i].url)";
                }
                else {
                    subjectList += "\(self.feedDetails.link_details[i].url), ";
                }
            }

            return Text(subjectList).modifier(RegularLinkText())
        }
        else {
            return Text("").modifier(RegularLinkText())
        }
    }






    var body: some View {


        ScrollView {
            ZStack(alignment: . top) {
                if self.feedDetails.images_details.count > 1 {
                    ZStack(alignment: .bottom) {
                        ModelPages(self.feedDetails.images_details, currentPage: self.$index, hasControl: false) { i, image in
                            ImageView(withURL: image.path)
                        }.aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))
                        self.feedDetails.images_details.count == 1 ? nil : PageControl(index: $index, maxIndex: self.feedDetails.images_details.count - 1, selected: Color.blue, unSelected: Color.white)
                            .frame(height: 10.0).padding(.bottom, 15);
                    }

                }
                else if self.feedDetails.images_details.count == 1 {
                    ImageView(withURL: feedDetails.images_details[0].path).aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))
                }

                (self.feedDetails.images_details.count == 0 && self.feedDetails.subjects_details.count == 0) ?
                Image("default")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    : nil;
                (self.feedDetails.images_details.count == 0 && self.feedDetails.subjects_details.count > 0) ?
                ImageView(withURL: feedDetails.subjects_details[0].attachment_details.path).aspectRatio(1 / 1, contentMode: .fit).background(Color(red: 239 / 255, green: 239 / 255, blue: 239 / 255))
                    : nil;
                HStack {
                    Spacer()
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image("closeButton").renderingMode(.original).resizable()
                            .frame(width: 30.0, height: 30.0).padding(.all, 5)
                    }


                }.padding([.top, .trailing], 15)
            }
            VStack {
                HStack {
                    Text(self.feedDetails.title).modifier(BoldTitle()).lineLimit(2)
                    Spacer()
                }
                HStack {
                    Spacer()

                    Button(action: { print("Working button") }) {
                        Image("moreOptions").resizable()
                            .frame(width: 15.0, height: 15.0)
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black)

                }
                HStack {
                    HStack {
                        Image("like_grey").resizable().frame(width: 20.0, height: 20.0).padding(.bottom, 3)
                        Text("\(String(self.feedDetails.is_interested == true ? self.feedDetails.interested_count + 1: self.feedDetails.interested_count))").modifier(FadedRegularText())
                    }
                    Spacer()
                    HStack {
                        Image("comment_grey").resizable().frame(width: 20.0, height: 20.0)
                        Text("\(String(self.feedDetails.comments_count))").modifier(FadedRegularText())
                    }
                    Spacer()
                    HStack {
                        Image("share_grey").resizable().frame(width: 20.0, height: 20.0)
                        Text("\(String(self.feedDetails.share_count))").modifier(FadedRegularText())
                    }
                    Spacer()
                    HStack {
                        Text("\(String(self.feedDetails.interested_count_from_school))").modifier(FadedRegularText()).font(.custom("SFProText-Regular", size: 10))
                        Image("likeBlue").resizable().frame(width: 16.0, height: 16.0).padding(.bottom, 2)
                        Text("in your school").modifier(FadedRegularText()).font(.custom("SFProText-Regular", size: 10))
                    }
                }

            }.padding([.top, .horizontal], 15)
            Divider()
            HStack {
                Button(action: { self.feedDetails.is_interested = !self.feedDetails.is_interested; }) {
                    Image(self.feedDetails.is_interested == false ? "like_black" : "likeBlue")
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
            }.padding(.top, 5.0).padding(.horizontal, 12)


            Divider()


            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Subjects").modifier(BoldText()).padding(.bottom, 5)
                    self.getSubjects().modifier(RegularText())
                }.padding(.top, 5)
                VStack(alignment: .leading) {
                    Text("Description").modifier(BoldText()).padding(.bottom, 5)
                    Text(self.feedDetails.description).modifier(RegularText())
                }.padding(.top, 25)
                if(self.feedDetails.link_details.count > 0) {
                    VStack(alignment: .leading) {
                        self.getLinks()
                    }.padding(.top, 25)
                }

                HStack {

                    Text("Helps you develop").modifier(BoldText())

                    Text("(ranked by user feedback)") .font(.custom("SFProText-Regular", size: 10))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)



                }.padding(.top, 25)
                VStack(alignment: .leading, spacing: 5) {
                    if(self.feedDetails.skills_marked.count > 0) {
                        ForEach(self.skillMarked1) { skill1 in
                            return Text("\(skill1.title)(\(skill1.marked))").modifier(RegularLinkText())
                        }
                        if(self.didSeeMore == true) {
                            ForEach(self.skillMarked2) { skill2 in
                                return Text("\(skill2.title)(\(skill2.marked))").modifier(RegularLinkText())
                            }
                        }
                        if(self.feedDetails.skills_marked.count > 10) {
                            Button(action: {
                                self.didSeeMore.toggle()
                            }, label: {
                                    Text(self.didSeeMore == true ? "See less" : "See more").modifier(FadedBoldText()) })

                        }

                    }
                    else {
                        Text("NA").modifier(RegularText())
                    }


                }.padding([.top, .bottom], 5)


            }.padding(.all, 15).frame(minWidth: 0,
                maxWidth: .infinity,
                alignment: .topLeading)

            VStack(alignment: .leading) {
                HStack {
                    Text(self.feedDetails.title).modifier(RegularTitle())
                    Spacer()
                }.padding(.bottom, 5)
                self.getSubjects().modifier(RegularSubText())

                VStack(alignment: .leading, spacing: 10) {
                    Button(action: { self.isInProgress = !self.isInProgress; }) {
                        Image(self.isInProgress == false ? "checkboxEmpty" : "checkboxFilled")
                            .renderingMode(.original).resizable().frame(width: 20.0, height: 20.0)
                        Text("In Progress").modifier(BoldText())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black).padding(.bottom, 5)
                    Button(action: { self.canGuide = !self.canGuide; }) {
                        Image(self.canGuide == false ? "checkboxEmpty" : "checkboxFilled")
                            .renderingMode(.original).resizable().frame(width: 20.0, height: 20.0)
                        Text("Can Guide").modifier(BoldText())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black).padding(.bottom, 5)
                    Button(action: { self.isDone = !self.isDone; }) {
                        Image(self.isDone == false ? "checkboxEmpty" : "checkboxFilled")
                            .renderingMode(.original).resizable().frame(width: 20.0, height: 20.0)
                        Text("Done").modifier(BoldText())
                    }.buttonStyle(BorderlessButtonStyle()).foregroundColor(Color.black).padding(.bottom, 5)
                }.padding(.top).padding(.bottom, 30)

            }.padding(.all, 15).background(Color(red: 229 / 255, green: 229 / 255, blue: 229 / 255)).frame(minWidth: 0,
                maxWidth: .infinity,
                alignment: .topLeading
            )




        }.padding(.bottom, 0).border(Color.red)
            .frame(alignment: .topLeading)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onDisappear() {
                self.settings.hideStatusBar = false
            }
            .onAppear() {
                self.settings.hideStatusBar = true
                self.getMarkedSkills()
        }

    }
}


struct FeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailView(
            feedDetails: Binding.constant(Feed(
                id: "",
                title: "",
                description: "",
                interested_count: 0,
                comments_count: 0,
                share_count: 0,
                interested_count_from_school: 0,
                is_interested: false,
                images_details: [ImageDetails(path: "")],
                subjects_details: [SubjectImages(attachment_details: AttachmentDetails(path: ""), title: "")],
                link_details: [LinkDetails(url: "")],
                skills_marked: [SkillsMarked(id: "", title: "", marked: 0)]
                ))
        )
    }
}
