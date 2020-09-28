//
//  Feeds.swift
//  besomeone-native
//
//  Created by Zaya Developer on 22/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var bottomTab: BottomTab

    @State private var feeds: [Feed] = []
    @State private var feedsLoaded = false;
    @State var hideStatusBar = false;
    @State var currentTab: Int = 0

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
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                VStack(spacing: 0) {

                                    Text("Mindful Self").padding(.all).onTapGesture {
                                        self.currentTab = 0
                                    }
                                    Rectangle().frame(height: 3).foregroundColor(self.currentTab == 0 ? Color.blue : Color.white)
                                    Divider()
                                }
                                VStack(spacing: 0) {
                                    Text("Mindful Self").padding(.all).onTapGesture {
                                        self.currentTab = 1
                                    }
                                    Rectangle().frame(height: 3).foregroundColor(self.currentTab == 1 ? Color.blue : Color.white)
                                    Divider()
                                }
                                VStack(spacing: 0) {
                                    Text("Mindful Self").padding(.all).onTapGesture {
                                        self.currentTab = 2
                                    }
                                    Rectangle().frame(height: 2).foregroundColor(self.currentTab == 2 ? Color.blue : Color.white)
                                    Divider()
                                }
                                VStack(spacing: 0) {
                                    Text("Mindful Self").padding(.all).onTapGesture {
                                        self.currentTab = 3
                                    }
                                    Rectangle().frame(height: 2).foregroundColor(self.currentTab == 3 ? Color.blue : Color.white)
                                    Divider()
                                }
                                VStack(spacing: 0) {
                                    Text("Mindful Self").padding(.all).onTapGesture {
                                        self.currentTab = 4
                                    }
                                    Rectangle().frame(height: 2).foregroundColor(self.currentTab == 4 ? Color.blue : Color.white)
                                    Divider()
                                }
                            }
                        }




//                        SkillListTab()
                        Spacer()
                    }

                }

            }.edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                .navigationBarHidden(true)


        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
