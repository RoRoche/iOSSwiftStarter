//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation

class ListRepoModuleAPIDataManager: ListRepoModuleAPIDataManagerInputProtocol
{
    init() {}
    
    func getRepos(user: String, completionHandler: (ListRepoModuleAPIDataManagerGetReposResult) -> Void) {
        let task = QueryListRepos(user: user);
        task.success { (repos: Array<RepoDTO>) -> Void in
            completionHandler(ListRepoModuleAPIDataManagerGetReposResult.Success(repos: repos));
            }.failure { (error: NSError?, isCancelled: Bool) -> Void in
                completionHandler(ListRepoModuleAPIDataManagerGetReposResult.Failure(error: error!));
        }
    }
}