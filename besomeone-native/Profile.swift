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

    @State private var priorityList: [PriorityList] = []
    @State private var profileLoaded = false;
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
                            Api().getPriorityList { (priorityListData) in
                                self.priorityList = priorityListData
                                self.profileLoaded = true
                            }
                        }.padding(.bottom).padding(.top, UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
                    Spacer()
                }.background(Color(red: 103 / 255, green: 234 / 255, blue: 164 / 255, opacity: 1.0))
                if self.profileLoaded == false {
                    VStack { Spacer()
                        Text("Loading")
                        Spacer() }
                }
                if self.profileLoaded == true {
                    VStack(spacing: 0) {
                        TalentTitle(currentTab: self.$currentTab, priorityList: self.$priorityList)




                        SkillDrag(skills: self.$priorityList[currentTab].skills)
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



struct TalentTitle: View {
    @Binding var currentTab: Int
    @Binding var priorityList: [PriorityList]


    func isTrue(order: Int) -> Bool {
        let orderInternal = order - 1;

        return self.currentTab == orderInternal;
    }

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(self.priorityList, id: \.id) { data in
                    VStack(spacing: 0) {
                        
                        Button(action: {
                            let order = data.order - 1;
                            self.currentTab = order
                        }, label: {
                                Text(data.title)
                                    .font(.custom("SFProText-Regular", size: 13))
                                    .foregroundColor(self.isTrue(order: data.order) ? Color.blue :  Color(red: 187/255, green:187/255, blue:187/255 ))
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: false)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                                    .padding(.horizontal, 10)
                                    .padding([.top, .bottom], 5)

                            })
                            


                        Rectangle().frame(height: 3).foregroundColor(self.currentTab == data.order - 1 ? Color.blue : Color.white)
                        Divider()
                    }

                }


            }

        }
    }

}

