//
//  Repo+CoreDataProperties.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 14/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Repo {
    
    @NSManaged var avatarUrl: String?
    @NSManaged var cloneUrl: String?
    @NSManaged var createdAt: String?
    @NSManaged var desc: String?
    @NSManaged var gitUrl: String?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var owner: String?

}
