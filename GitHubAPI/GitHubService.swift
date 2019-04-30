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
    
    /* Searches for GitHub users. If user is found, save as a Core Data entity in the given context.
     
     TODO add a delegate or completion handler to notify
     the caller that the request succeeded or errored. */
    
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
                
                // Add context to the decoder's userInfo dictionary, so when the decoder
                // decodes the JSON into a UserEntity object, the object will be associcated
                // with this NSManagedObjectContext.
                decoder.userInfo[CodingUserInfoKey.context!] = context
                do {
                    // In this version, we don't need a reference to the decoded object, since the ViewController
                    // will use a FetchedResultsController to get all of the data from the database,
                    // including the newly-saved UserEntity.
                    // But, here it is, just in case you need it in other programs.
                    // Could also use completion handler (or delegate) to provide the gitHubUser to the caller (or other object that needs it).
                    let gitHubUser = try decoder.decode(UserEntity.self, from: data)
                    try context.save()  // Saves the new entity
                } catch {
                    print("Error decoding or saving: \(error)")
                }
            }
        })
        
        task.resume()  // Don't forget!
    }
    
}
