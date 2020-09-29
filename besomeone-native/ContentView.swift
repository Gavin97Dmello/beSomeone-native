//
//  ContentView.swift
//  besomeone-native
//
//  Created by Zaya Developer on 10/09/10.
//  Copyright © 1010 Zaya Developer. All rights reserved.
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
struct RegularTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 16))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)

    }
}
struct BoldText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 13))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}
struct RegularText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}
struct RegularLinkText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}

struct RegularSelectedSkillTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: false)

    }
}
struct RegularUnselectedSkillTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color(red: 187/255, green:187/255, blue:187/255 ))
            .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: false)

    }
}
struct FadedBoldText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 13))
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255, opacity: 1.0))
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}
struct FadedRegularText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255, opacity: 1.0))
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}

struct RegularSubText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 10))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}

struct FadedBoldSubText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 10))
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255, opacity: 1.0))
            .multilineTextAlignment(.leading) .fixedSize(horizontal: false, vertical: true)

    }
}



struct ContentView: View {

    @State var bottomTabIndex: Int = 1;
    @EnvironmentObject var bottomTab: BottomTab


    var body: some View {
        VStack {
            if(self.bottomTabIndex == 0) {
            GeometryReader {
                geom in
                
                Feeds().frame(height:  geom.size.height - 70).padding(.bottom, 0)
            }
            }
            if(self.bottomTabIndex == 1) {
            GeometryReader {
                geom in
                
                Profile().frame(height:  geom.size.height - 70).padding(.bottom, 0)
            }
            }
            self.bottomTab.showBottomTab == true ? CustomBottomTab(bottomTabIndex: self.$bottomTabIndex): nil

        }.edgesIgnoringSafeArea(.all)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct CustomBottomTab: View {

    @Binding var bottomTabIndex: Int

    var body: some View {
        VStack {
            Divider()

            HStack(spacing: 0) {

                VStack {
                    Button(action: {
                        self.bottomTabIndex = 0
                    }, label: {
                            Image("feedIcon").renderingMode(.original).resizable().frame(width: self.bottomTabIndex == 0 ? 50 : 40, height: self.bottomTabIndex == 0 ? 50 : 40).padding(.all, 10)
                        })
                }
                    .frame(minWidth: 0, maxWidth: .infinity)

                VStack {
                    Button(action: {
                        self.bottomTabIndex = 1
                    }, label: {
                            Image("profileIcon").renderingMode(.original).resizable().frame(width: self.bottomTabIndex == 1 ? 50 : 40, height: self.bottomTabIndex == 1 ? 50 : 40).padding(.all, 10)
                        })
                }
                    .frame(minWidth: 0, maxWidth: .infinity)

                VStack {
                    Button(action: {
                        self.bottomTabIndex = 2
                    }, label: {
                            Image("notifyIcon").renderingMode(.original).resizable().frame(width: self.bottomTabIndex == 2 ? 50 : 40, height: self.bottomTabIndex == 2 ? 50 : 40).padding(.all, 10)                        })
                }
                    .frame(minWidth: 0, maxWidth: .infinity)

            }.padding(.bottom,10)
                .frame(minWidth: 0, maxWidth: .infinity)




        }

    }
}


//struct NavigationItem {
//    var view: AnyView
//}
//final class NavigationStack: ObservableObject {
//    @Published var viewStack: [NavigationItem] = []
//    @Published var currentView: NavigationItem
//    init(_ currentView: NavigationItem) {
//        self.currentView = currentView
//    }
//    func unwind() {
//        if viewStack.count == 0 {
//            return }
//        let last = viewStack.count - 1
//        currentView = viewStack[last]
////       viewStack.remove(at: last)
//    }
//    func advance(_ view: NavigationItem) {
//        viewStack.append(currentView)
//        currentView = view
//    }
//
//
//}
//
//struct NavigationHost: View {
//    @EnvironmentObject var navigation: NavigationStack
//    @EnvironmentObject var userSettings: UserSettings
//    @EnvironmentObject var showBottomTab: BottomTab
//
//
//    var body: some View {
//        self.navigation.currentView.view
//    }
//}





