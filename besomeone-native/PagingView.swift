//
//  PagingView.swift
//  besomeone-native
//
//  Created by Zaya Developer on 18/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct PagingView<Content>: View where Content: View {

    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false

    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {

                        self.content()
                    }
                }
                    .content.offset(x: self.offset(in: geometry), y: 0)
                    
                    .frame(width: geometry.size.width, height: geometry.size.width - 10)
                    .gesture(
                        DragGesture().onChanged { value in
                            self.dragging = true
                            self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                        }
                            .onEnded { value in
                                let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                                let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                                self.index = self.clampedIndex(from: predictedIndex)
                                withAnimation(.easeOut) {
                                    self.dragging = false
                                }
                        }
                    )
            }

            maxIndex > 0 ?
            PageControl(index: $index, maxIndex: maxIndex)
                : nil
        }
    }

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            if maxIndex > 0 {
                print(-CGFloat(self.index+1) * geometry.size.width)
            }
            return -CGFloat(self.index+1) * geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.blue : Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255, opacity: 0.2))
                    .frame(width: 8, height: 8)
            }
        }
            .padding(15)
    }
}


// ImageView


