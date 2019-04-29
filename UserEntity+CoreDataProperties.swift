//
//  UserEntity+CoreDataProperties.swift
//  GitHubAPI
//
//  Created by student1 on 4/29/19.
//  Copyright © 2019 clara. All rights reserved.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var publicRepos: Int16
    @NSManaged public var htmlUrl: String?

}
