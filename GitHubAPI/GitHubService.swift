//
//  GitHubService.swift
//  GitHubAPI
//
//  Created by student1 on 4/29/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import CoreData

class GitHubService {
    
    func searchFor(user: String, context: NSManagedObjectContext) {
        
        let urlStr = "https://api.github.com/users/\(user)"
        let url = URL(string: urlStr)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 {
                    print("\(user) Not found")
                    return
                }
            }
            
            if let error = error {
                print("Error requesting data \(error)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = context
                do {
                    let gitHubUser = try decoder.decode(UserEntity.self, from: data)
                    try context.save()  // saves the entity
                } catch {
                    print("Error decoding or saving: \(error)")
                }
            }
        })
        
        task.resume()
    }
    
}
