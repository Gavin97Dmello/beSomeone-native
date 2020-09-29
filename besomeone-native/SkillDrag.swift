//
//  SkillListTab.swift
//  besomeone-native
//
//  Created by Zaya Developer on 28/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct SkillDrag: View {
    @Binding var skills: [SkillList]
    @State private var isEditable = false

    var body: some View {


        List {
            ForEach(self.skills, id: \.id) { skillData in
                HStack {
                    Image("drag_blue_new").resizable().frame(width: 30, height: 30).onLongPressGesture {
                        withAnimation {
                            self.isEditable = true
                        } }
                    Text(skillData.title)

                }
            }
                .onMove(perform: move)

        }
            .environment(\.editMode, .constant(.active))
    }


    func move(from source: IndexSet, to destination: Int) {
        skills.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditable = false
        }
    }
}

struct SkillDrag_Previews: PreviewProvider {
    static var previews: some View {
        SkillDrag(skills: Binding.constant([SkillList(id: "", title: "", description: "", position: 0, all_count: 0)]))
    }
}



