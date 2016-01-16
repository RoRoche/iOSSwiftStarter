//
//  Repo.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 14/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import Foundation
import CoreData


class Repo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func populateWithDto(repoDto: RepoDTO) {
        self.id = repoDto.id;
        self.name = repoDto.name;
        self.owner = repoDto.owner;
        self.avatarUrl = repoDto.avatarUrl;
        self.desc = repoDto.desc;
        self.createdAt = repoDto.createdAt;
        self.gitUrl = repoDto.gitUrl;
        self.cloneUrl = repoDto.cloneUrl;
    }
    
}
