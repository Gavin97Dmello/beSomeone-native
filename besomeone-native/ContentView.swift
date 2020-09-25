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

    var body: some View {
        NavigationHost()
        .environmentObject(NavigationStack(
            NavigationItem( view: AnyView(Feeds())))).environmentObject(UserSettings())
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavigationItem{
   var view: AnyView
}

final class NavigationStack: ObservableObject {
@Published var viewStack: [NavigationItem] = []
@Published var currentView: NavigationItem
init(_ currentView: NavigationItem ){
   self.currentView = currentView
}
    func unwind(){
       if viewStack.count == 0{
          return }
       let last = viewStack.count - 1
       currentView = viewStack[last]
       viewStack.remove(at: last)
    }
    func advance(_ view:NavigationItem){
       viewStack.append( currentView)
       currentView = view
    }
    
    
}

struct NavigationHost: View{
   @EnvironmentObject var navigation: NavigationStack
   @EnvironmentObject var userSettings: UserSettings
   
   var body: some View {
      self.navigation.currentView.view
   }
}

