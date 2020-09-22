//
//  ContentView.swift
//  besomeone-native
//
//  Created by Zaya Developer on 10/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct BoldTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 16))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
    }
}
struct BoldText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 13))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
    }
}
struct RegularText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
    }
}
struct FadedBoldText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 13))
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255, opacity: 1.0))
            .multilineTextAlignment(.leading)
    }
}
struct FadedRegularText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255, opacity: 1.0))
            .multilineTextAlignment(.leading)
    }
}

struct ContentView: View {

    @State private var feeds: [Feed] = []
    @State private var feedsLoaded = false;




    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Text("beSomeone")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white).onAppear {
                        UIApplication.setStatusBarStyle(.lightContent)
                        Api().getFeeds { (feeds) in
                            self.feeds = feeds
                            self.feedsLoaded = true
                        }
                    }.padding(.bottom).padding(.top, UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
                Spacer()
            }.background(Color(red: 103 / 255, green: 234 / 255, blue: 164 / 255, opacity: 1.0))
            if self.feedsLoaded == false {
                VStack { Spacer()
                    Text("Loading")
                    Spacer() }
            }
            if self.feedsLoaded == true {
                List {
                    ForEach(feeds.indices, id: \.self) { index in
                        FeedCard(title: self.$feeds[index].title,
                            description: self.$feeds[index].description,
                            interested_count: self.$feeds[index].interested_count,
                            comments_count: self.$feeds[index].comments_count,
                            share_count: self.$feeds[index].share_count,
                            interested_count_from_school: self.$feeds[index].interested_count_from_school,
                            is_interested: self.$feeds[index].is_interested,
                            image_details: self.$feeds[index].images_details,
                            subject_details: self.$feeds[index].subjects_details
                        ).listRowInsets(EdgeInsets())
                    }
                }
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

