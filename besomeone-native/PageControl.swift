//
//  PagingView.swift
//  besomeone-native
//
//  Created by Zaya Developer on 18/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int
    let selected: Color
    let unSelected: Color

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? self.selected : self.unSelected)
                    .frame(width: 8, height: 8)
            }
        }
            .padding(15)
    }
}


// ImageView


