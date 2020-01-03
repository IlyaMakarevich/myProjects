//
//  Tweet2.swift
//  twitter2
//
//  Created by MacBook Pro  on 02.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

import Foundation

 /* class Tweet2: Decodable {
    
    var screen_name: String?
    var name: String?
    var text: String?
    var created_at: String?
    var profile_image_url: String?
    
    enum CodingKeys: String, CodingKey {
        case created_at
        case text
        case profile_image_url
        case user
    }
    
    enum UserCodingKeys: String, CodingKey {
        case name = "name"
        case screen_name = "screen_name"
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.text = try? container.decode(String.self, forKey: .text)
        self.profile_image_url = try? container.decode(String.self, forKey: .profile_image_url)
        
        // Nested user{}
        let userContainer = try container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .user)
        self.name = try userContainer.decode(String.self, forKey: .name)
        self.screen_name = try userContainer.decode(String.self, forKey: .screen_name)
    }
}
*/

struct Tweet3 {
    
    let text: String?
    let created_at: String?
    
    let user_data: (screen_name: String, name: String, profile_image_url: String)
}

extension Tweet3 {
    
    init?(json: [String: Any]) {
        guard let text = json["text"] as? String,
            let created_at = json["created_at"] as? String,
            let user_data = json["user"] as? [String: String],
            let screen_name = user_data["screen_name"],
            let name = user_data["name"],
            let profile_image_url = user_data["profile_image_url"]
            else {
                return nil
        }
        
        
        self.text = text
        self.created_at = created_at
        self.user_data = (screen_name, name, profile_image_url)
        
}
}


