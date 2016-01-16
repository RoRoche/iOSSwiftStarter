//
//  QueryListRepos.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 13/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import Foundation
import SwiftTask
import Alamofire
import ObjectMapper
import Kugel

public class OnQueryListReposDidFinish: AbstractQueryNotification {
    public static let Name: String = "OnQueryListReposDidFinish";
}

class QueryListRepos: Task<Void, Array<RepoDTO>, NSError> {
    
    init(user: String!) {
        
        let initClosure: InitClosure = { progress, fulfill, reject, configure in
            
            let request = Alamofire.request(ApiService.ListRepos(user: user, sort: ApiService.ListReposSort.DESC))
                .responseJSON { response in
                    if(response.result.error != nil) {
                        reject(response.result.error!);
                    } else {
                        if let JSON = response.result.value {
                            let repos: Array<RepoDTO> = Mapper<RepoDTO>().mapArray(JSON)!;
                            fulfill(repos);
                        } else {
                            let error: NSError = NSError(domain: "JSON parsing", code: 0, userInfo: [:]);
                            reject(error);
                        }
                    }
            }
            
            // we plug the cancel method of the Task to the cancel method of the request
            configure.cancel = {
                request.cancel();
            }
        };
        
        super.init(weakified: false, paused: false, initClosure: initClosure);
        
        self.success { (value: Array<RepoDTO>) -> Void in
            
            let userInfo: [NSObject: AnyObject] = OnQueryListReposDidFinish.buildUserInfoSuccess(value as AnyObject);
            Kugel.publish(OnQueryListReposDidFinish.Name, object: self, userInfo:userInfo);
            }.failure { (error: NSError?, isCancelled: Bool) -> Void in
                let userInfo: [NSObject: AnyObject] = OnQueryListReposDidFinish.buildUserInfoFailure(error!, isCancelled: isCancelled);
                Kugel.publish(OnQueryListReposDidFinish.Name, object: self, userInfo:userInfo);
        }
    }
    
}