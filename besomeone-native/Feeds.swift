//
//  Feeds.swift
//  besomeone-native
//
//  Created by Zaya Developer on 22/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct Feeds: View {
    @EnvironmentObject var bottomTab: BottomTab

    @State private var feeds: [Feed] = []
    @State private var feedsLoaded = false;
    @State var hideStatusBar = false;

    var body: some View {
        NavigationView {

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
                                print(feeds[0])
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
                        ForEach(self.feeds.indices, id: \.self) { index in

                            FeedCard(
                                feedCardData: self.feeds[index], hideStatusBar: self.$hideStatusBar
                            ).listRowInsets(EdgeInsets())

                        }
                        HStack {
                            Spacer()
                            Text("The end").modifier(RegularText())
                            Spacer()
                        }.padding(.top)
                            .padding(.bottom, 30)

                    }

                }
            }
                .navigationBarTitle("")
                .navigationBarHidden(true)
             

        }.statusBar(hidden: hideStatusBar)
    }
}

struct Feeds_Previews: PreviewProvider {
    static var previews: some View {
        Feeds()
    }
}
