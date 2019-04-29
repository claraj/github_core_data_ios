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
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case name = "name"
        case htmlUrl = "html_url"
        case publicRepos = "public_repos"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        let managedObjectContext = decoder.userInfo[CodingUserInfoKey.context!] as! NSManagedObjectContext //else { fatalError("Where's the context?") }
        guard let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedObjectContext) else { fatalError("No UserEntity") }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.publicRepos = try container.decodeIfPresent(Int16.self, forKey: .publicRepos)!
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
    
}
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
