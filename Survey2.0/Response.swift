//
//  Response.swift
//  Survey2.0
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

class Response {
    
    private let kName = "name"
    private let kResponseText = "repsonseText"
    
    var name: String
    var responseText: String
    var UUID: NSUUID
    
    init(name: String, responseText: String) {
        self.name = name
        self.responseText = responseText
        self.UUID = NSUUID()
    }
    
    init?(dictionary: [String: AnyObject], UUID: String) {
        guard let name = dictionary[kName] as? String,
            responseText = dictionary[kResponseText] as? String,
            UUID = NSUUID(UUIDString: UUID)
            
            else { return nil }
        
        self.name = name
        self.responseText = responseText
        self.UUID = UUID
    }
    
    var endpoint: NSURL? {
        return ResponseController.baseURL?.URLByAppendingPathComponent(UUID.UUIDString).URLByAppendingPathExtension("json")
    }
    
    var jsonData: NSData? {
        return try? NSJSONSerialization.dataWithJSONObject(dictionaryRep, options: .PrettyPrinted)
    }
    
    var dictionaryRep: [String: AnyObject] {
        return [kName: name, kResponseText: responseText]
    }
}