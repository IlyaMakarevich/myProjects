//
//  Post.swift
//  twitter
//
//  Created by MacBook Pro  on 21.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import Foundation


class Post {
    
    var id: Int
    var title: String
    
    init? (json: [String: Any]) {
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String
        else {
            return nil
        }
        self.id = id
        self.title = title
    }
    
    static func getArray(from jsonArray: Any) -> [Post]? {
        
        guard let jsonArray = jsonArray as? Array<[String:Any]> else {return nil}
        return jsonArray.compactMap{Post(json: $0)}
        
//        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
//         var posts: [Post] = []
//
//         for jsonObject in jsonArray {
//             if let post = Post(json: jsonObject) {
//                 posts.append(post)
//             }
//         }
//         return posts
    }
}
