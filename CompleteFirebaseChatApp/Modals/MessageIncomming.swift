//
//  MessageIncomming.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 26/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import Foundation
struct MessageIncoming {
    var fromId : String?
    var toId : String?
    var message : String?
    
    init(dictionary : NSDictionary) {
        fromId = dictionary["fromId"] as? String
        toId = dictionary["toId"] as? String
        message = dictionary["message"] as? String
    }
}
