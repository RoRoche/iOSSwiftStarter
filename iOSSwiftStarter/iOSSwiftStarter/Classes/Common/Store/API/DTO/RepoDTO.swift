//
//  RepoDTO.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 12/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import Foundation
import ObjectMapper

class RepoDTO: Mappable {
    
    var id: Int?;
    var name: String?;
    var owner: String?;
    var avatarUrl: String?;
    var desc: String?;
    var createdAt: String?;
    var gitUrl: String?;
    var cloneUrl: String?;
    
    init() {}
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id          <- map["id"];
        name        <- map["name"];
        owner       <- map["owner.login"];
        avatarUrl   <- map["owner.avatar_url"];
        desc        <- map["description"];
        createdAt   <- map["created_at"];
        gitUrl      <- map["git_url"];
        cloneUrl    <- map["clone_url"];
    }
    
}