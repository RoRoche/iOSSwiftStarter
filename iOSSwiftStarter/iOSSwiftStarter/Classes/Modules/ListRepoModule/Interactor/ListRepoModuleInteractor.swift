//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation

class ListRepoModuleInteractor: ListRepoModuleInteractorInputProtocol
{
    weak var presenter: ListRepoModuleInteractorOutputProtocol?
    var APIDataManager: ListRepoModuleAPIDataManagerInputProtocol?
    var localDatamanager: ListRepoModuleLocalDataManagerInputProtocol?
    
    init() {}
    
    func loadRepos(user: String, pulledToRefresh: Bool) {
        presenter?.presentLoadingFromNetwork(pulledToRefresh);
        
        APIDataManager?.getRepos(user) {
            [unowned self](result) -> Void in
            
            switch(result) {
            case .Success(let repos):
                self.deleteRepos(user, repos: repos, pulledToRefresh: pulledToRefresh);
                break;
            case .Failure(let error):
                self.presenter?.presentError(error);
                break;
            }
        }
    }
    
    private func deleteRepos(user: String, repos: Array<RepoDTO>, pulledToRefresh: Bool) {
        localDatamanager?.deleteRepos(user) {
            [unowned self](result) -> Void in
            
            switch(result) {
            case .Success(_):
                self.saveRepos(user, repos: repos, pulledToRefresh: pulledToRefresh);
                break;
            case .Failure(let error):
                self.presenter?.presentError(error);
                break;
            }
        }
    }
    
    private func saveRepos(user: String, repos: Array<RepoDTO>, pulledToRefresh: Bool) {
        localDatamanager?.saveRepos(repos) {
            [unowned self](result) -> Void in
            
            switch(result) {
            case .Success():
                self.getRepos(user, pulledToRefresh: pulledToRefresh);
                break;
            case .Failure(let error):
                self.presenter?.presentError(error);
                break;
            }
        }
    }
    
    private func getRepos(user: String, pulledToRefresh: Bool) {
        presenter?.presentLoadingFromDatabase(pulledToRefresh);
        
        localDatamanager?.getRepos(user) {
            [unowned self](result) -> Void in
            
            switch(result) {
            case .Success(let repos):
                self.presenter?.presentRepos(repos, pulledToRefresh: pulledToRefresh);
                break;
            case .Failure(let error):
                self.presenter?.presentError(error);
                break;
            }
        }
    }
}