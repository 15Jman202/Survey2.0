//
//  ResponseController'.swift
//  Survey2.0
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

class ResponseController {
    
    static let baseURL = NSURL(string: "https://surveyv2-f6dcb.firebaseio.com/api")
    static let getterEndpoint = baseURL?.URLByAppendingPathExtension("json")
    
    static func getResponses(completion: ((responses: [Response]) -> Void)?) {
        
        guard let url = getterEndpoint else { return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            var responseArray: [Response] = []
            
            defer {
                completion?(responses: responseArray); print(responseArray)
            }
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            guard let data = data,
                JSONDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: [String: AnyObject]]
                else { return }
            
            let responses = JSONDictionary.flatMap { Response(dictionary: $0.1, UUID: $0.0) }
            responseArray = responses
        }
    }
    
    static func putResponse(name: String, text: String, completion: (success: Bool) -> Void) {
        let response = Response(name: name, responseText: text)
        
        guard let url = response.endpoint else { return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Put, urlParameters: nil, body: response.jsonData) { (data, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(success: false)
                return
            } else {
                completion(success: true)
                print("Successfully Saved to Endpoint.")
                return
            }
        }
    }
}










