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
struct RegularLinkText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 13))
            .foregroundColor(Color.blue)
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

struct RegularSubText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Regular", size: 10))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
    }
}

struct FadedBoldSubText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProText-Semibold", size: 10))
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255, opacity: 1.0))
            .multilineTextAlignment(.leading)
    }
}



struct ContentView: View {
    
    @EnvironmentObject var settings: UserSettings


    var body: some View {
        NavigationView {
            Feeds()
        }.statusBar(hidden: settings.hideStatusBar)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

