//
//  Feeds.swift
//  besomeone-native
//
//  Created by Zaya Developer on 22/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct Feeds: View {
    @State private var feeds: [Feed] = []
    @State private var feedsLoaded = false;
    @EnvironmentObject var settings: UserSettings

    var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    Text("beSomeone")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white).onAppear {
//                            UIApplication.setStatusBarStyle(.lightContent)
//                            var preferredStatusBarStyle: UIStatusBarStyle {
//                                return .lightContent // .default
//                            }
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
                        ForEach(feeds.indices, id: \.self) { index in

                            FeedCard(
                                feedCardData: self.feeds[index]
                            ).listRowInsets(EdgeInsets())
                            
                        }
                        HStack {
                            Spacer()
                            Text("The end").modifier(RegularText())
                            Spacer()
                        }.padding(.top, 5)
                        .padding(.bottom,10)
                       
                    }
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                .navigationBarHidden(true)
    }
}

struct Feeds_Previews: PreviewProvider {
    static var previews: some View {
        Feeds()
    }
}
