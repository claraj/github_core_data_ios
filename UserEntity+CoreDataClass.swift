//
//  UserEntity+CoreDataClass.swift
//  GitHubAPI
//
//  Created by student1 on 4/29/19.
//  Copyright © 2019 clara. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject, Decodable {
    
    // For converting JSON names to attribute names
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case name = "name"
        case htmlUrl = "html_url"
        case publicRepos = "public_repos"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        // Check that the decoder has a context in the userInfo dictionary. See also extension to CodingUserInfoKey, below
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] else { fatalError("Provide a NSManagedObjectContext") }
        guard let managedObjectContext = context as? NSManagedObjectContext else { fatalError("Provide a NSManagedObjectContext") }
        guard let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedObjectContext) else { fatalError("No UserEntity") }
        
        // Call standard NSManagedEntity initializer
        self.init(entity: entity, insertInto: managedObjectContext)
        
        // The container holds all of the JSON data
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode all of the attributes
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.publicRepos = try container.decodeIfPresent(Int16.self, forKey: .publicRepos) ?? 0
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
    }
}

// Add an extra attribute to the CodingUserInfoKey struct, used to provide the NSManagedObjectContext to the decoder.
extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
