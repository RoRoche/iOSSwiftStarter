//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation
import CoreStore

class ListRepoModuleLocalDataManager: ListRepoModuleLocalDataManagerInputProtocol
{
    init() {}
    
    func deleteRepos(user: String, completionHandler: (ListRepoModuleLocalDataManagerDeleteReposResult) -> Void) {
        DataStoreManager.sharedInstance.dataStack.beginAsynchronous({ (transaction) -> Void in
            
            let deleted: Int = transaction.deleteAll(
                From(Repo),
                Where("%K == %@", "owner", user)
                )!;
            
            transaction.commit();
            
            completionHandler(ListRepoModuleLocalDataManagerDeleteReposResult.Success(deleted: deleted));
        });
    }
    
    func saveRepos(repos: Array<RepoDTO>, completionHandler: (ListRepoModuleLocalDataManagerSaveReposResult) -> Void) {
        DataStoreManager.sharedInstance.dataStack.beginAsynchronous({ (transaction) -> Void in
            
            for repoDto: RepoDTO in repos {
                let repo: Repo = transaction.create(Into(Repo));
                repo.populateWithDto(repoDto);
            }
            
            transaction.commit();
            
            completionHandler(ListRepoModuleLocalDataManagerSaveReposResult.Success());
        });
    }
    
    func getRepos(user: String, completionHandler: (ListRepoModuleLocalDataManagerGetReposResult) -> Void) {
        DataStoreManager.sharedInstance.dataStack.beginAsynchronous { (transaction) -> Void in
            let results: Array<Repo> = transaction.fetchAll(
                From(Repo),
                Where("%K == %@", "owner", user)
                )!;
            
            completionHandler(ListRepoModuleLocalDataManagerGetReposResult.Success(repos: results));
            
        }
    }
}