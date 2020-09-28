//
//  Structures.swift
//  besomeone-native
//
//  Created by Zaya Developer on 28/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//

import SwiftUI

struct FeedResponse: Decodable {
    let results: [Feed]
}

struct Feed: Decodable, Identifiable {
    let id: String
    var title: String
    var description: String
    var interested_count: Int
    var comments_count: Int
    var share_count: Int
    var interested_count_from_school: Int
    var is_interested: Bool
    var images_details: [ImageDetails]
    var subjects_details: [SubjectImages]
    var link_details: [LinkDetails]
    var skills_marked: [SkillsMarked]

}

struct SkillsMarked: Decodable, Identifiable {
    let id: String
    var title: String
    var marked: Int
}


struct LinkDetails: Decodable, Identifiable {
    let id = UUID()
    var url: String
}

struct ImageDetails: Decodable, Identifiable {
    let id = UUID()
    var path: String
}

struct SubjectImages: Decodable, Identifiable {
    let id = UUID()
    var attachment_details: AttachmentDetails
    var title: String
}

struct AttachmentDetails: Decodable, Identifiable {
    let id = UUID()
    var path: String
}
