//
//  users.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 25/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import Foundation
struct UsersIncoming {
    var name : String?
    var email : String?
    var image : String?
    var id : String?
    init(dictionary : NSDictionary) {
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        image = dictionary["profileImage"] as? String
        id = dictionary["id"] as? String
    }
}
