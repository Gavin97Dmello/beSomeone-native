//
//  ApiCaller.swift
//  besomeone-native
//
//  Created by Zaya Developer on 10/09/20.
//  Copyright © 2020 Zaya Developer. All rights reserved.
//
import Foundation
import SwiftUI


//struct Feed: Codable, Identifiable {
//    let id: String
//    var author: String
//    var title: String
//    var can_edit_delete: Bool
//    var can_guide: Bool
//    var comments_count: Int
//    var created: String
////    var default_image: null
//    var description: String
////    var guides: []
////    var images: ["8b6d8f84-7410-4c1b-93aa-4b839e416e44"]
////    var images_details: [{…}]
//    var interested_count: Int
//    var interested_count_from_school: Int
////    var interested_users: ["0c36de38-eba9-4263-a72b-1e29e7d2295a"]
//    var is_interested: Bool
//    var is_owner: Bool
////    var link_details: []
////    var links: []
//    var share_count: Int
//    var share_link: String
////    var skills: (2) ["cfce054d-ec54-4489-8307-106f13fc81a9", "64ef2840-ca09-49d1-9444-5c5d57c847e2"]
////    var skills_details: (2) [{…}, {…}]
////    var skills_marked: (8) [{…}, {…}, {…}, {…}, {…}, {…}, {…}, {…}]
//    var slug: String
////    var subjects: (2) ["e1397ab6-cc89-4e13-9c48-a275eb1aab1a", "713df918-32e3-423e-9157-f7266fd48802"]
////    var subjects_details: (2) [{…}, {…}]
////    var tags: []
//    var updated: String
//    var user_guides_count: Int
////    var user_status: null
//}


struct FeedResponse: Decodable {
    let results: [Feed]
}

struct Feed: Decodable, Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var interested_count: Int
    var comments_count: Int
    var share_count: Int
    var interested_count_from_school: Int
    var is_interested: Bool
    var images_details: [ImageDetails]
    var subjects_details: [SubjectImages]

}

struct ImageDetails: Decodable, Identifiable {
    let id = UUID()
    var path: String
}

struct SubjectImages: Decodable, Identifiable {
    let id = UUID()
    var attachment_details: AttachmentDetails
}

struct AttachmentDetails: Decodable, Identifiable {
    let id = UUID()
    var path: String
}



class Api {
    func getFeeds(completion: @escaping ([Feed]) -> ()) {
        guard let url = URL(string: "https://test.api.talentunbound.zaya.in/api/v1/adventures/")else {return}
        var request = URLRequest(url: url)
        request.addValue("Token c333cbbc045cb20c09f72528869e3cce1ede2917", forHTTPHeaderField: "Authorization")
//        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, _, _) in

            guard let data = data else {return}

          
             let feeds = try! JSONDecoder().decode(FeedResponse.self, from: data)
            DispatchQueue.main.async {
                completion(feeds.results)
            }
        }.resume()
    }
}

