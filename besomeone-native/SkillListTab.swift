//
//  SkillListTab.swift
//  besomeone-native
//
//  Created by Zaya Developer on 28/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct SkillListTab: View {
    @Binding var skills: [SkillList]
    @State private var isEditable = false

    var body: some View {


        List {
            ForEach(self.skills, id: \.self) { skillData in
                HStack {
                    Image("apple").resizable().frame(width: 20, height: 20).onLongPressGesture {
                        withAnimation {
                            self.isEditable = true
                        } }
                    Text(skillData.name)

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

struct SkillListTab_Previews: PreviewProvider {
    static var previews: some View {
        SkillListTab(skills: Binding.constant([SkillList(id: "", name: "", value: 0)]))
    }
}


struct SkillList: Decodable, Identifiable, Hashable {
    var id: String
    var name: String
    var value: Int
}
