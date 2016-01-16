//
//  SpecListRepoModuleInteractor.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 03/01/2016.
//  Copyright © 2016 Romain Rochegude. All rights reserved.
//

import UIKit
import Quick
import Nimble

class SpecListRepoModuleInteractor: QuickSpec {
    
    class Mock_ListRepoModulePresenter: ListRepoModuleInteractorOutputProtocol {
        init() {}
        
        var presentLoadingFromNetworkWasCalled: Bool = false;
        var presentLoadingFromNetworkPulledToRefresh: Bool = false;
        func presentLoadingFromNetwork(pulledToRefresh: Bool) {
            presentLoadingFromNetworkWasCalled = true;
            presentLoadingFromNetworkPulledToRefresh = pulledToRefresh;
        }
        
        var presentLoadingFromDatabaseWasCalled: Bool = false;
        var presentLoadingFromDatabasePulledToRefresh: Bool = false;
        func presentLoadingFromDatabase(pulledToRefresh: Bool) {
            presentLoadingFromDatabaseWasCalled = true;
            presentLoadingFromDatabasePulledToRefresh = pulledToRefresh;
        }
        
        var presentReposWasCalled: Bool = false;
        var presentReposRepos: Array<Repo> = [];
        var presentReposPulledToRefresh: Bool = false;
        func presentRepos(repos: Array<Repo>, pulledToRefresh: Bool) {
            presentReposWasCalled = true;
            presentReposRepos = repos;
            presentReposPulledToRefresh = pulledToRefresh;
        }
        
        var presentErrorWasCalled: Bool = false;
        func presentError(error: NSError) {
            presentErrorWasCalled = true;
        }
    }
    
    class Mock_ListRepoModuleAPIDataManager: ListRepoModuleAPIDataManagerInputProtocol {
        
        var mockRepos: Array<RepoDTO> = Array<RepoDTO>();
        init() {
            let repo: RepoDTO = RepoDTO();
            repo.id = 1;
            repo.name = "test";
            
            mockRepos.append(repo);
        }
        
        var getReposWasCalled: Bool = false;
        var getReposUser: String = "";
        func getRepos(user: String, completionHandler: (ListRepoModuleAPIDataManagerGetReposResult) -> Void) {
            getReposWasCalled = true;
            getReposUser = user;
            
            // returns mock repos
            completionHandler(ListRepoModuleAPIDataManagerGetReposResult.Success(repos: self.mockRepos));
        }
    }
    
    class Mock_ListRepoModuleLocalDatamanager: ListRepoModuleLocalDataManagerInputProtocol {
        var mockRepos: Array<Repo> = Array<Repo>();
        init() {
            let repo: Repo = Repo();
            mockRepos.append(repo);
        }
        
        var deleteReposWasCalled: Bool = false;
        var deleteReposUser: String = "";
        func deleteRepos(user: String, completionHandler: (ListRepoModuleLocalDataManagerDeleteReposResult) -> Void) {
            deleteReposWasCalled = true;
            deleteReposUser = user;
            completionHandler(ListRepoModuleLocalDataManagerDeleteReposResult.Success(deleted: 1));
        }
        
        var saveReposWasCalled: Bool = false;
        func saveRepos(repos: Array<RepoDTO>, completionHandler: (ListRepoModuleLocalDataManagerSaveReposResult) -> Void) {
            saveReposWasCalled = true;
            completionHandler(ListRepoModuleLocalDataManagerSaveReposResult.Success());
        }
        
        var getReposWasCalled: Bool = false;
        var getReposUser: String = "";
        func getRepos(user: String, completionHandler: (ListRepoModuleLocalDataManagerGetReposResult) -> Void) {
            getReposWasCalled = true;
            getReposUser = user;
            
            // returns mock repos
            completionHandler(ListRepoModuleLocalDataManagerGetReposResult.Success(repos: self.mockRepos));
        }
    }
    
    override func spec() {
        describe("When user asks for loading repos") {
            context("and when it is the perfect nominal case") {
                let interactor: ListRepoModuleInteractorInputProtocol = ListRepoModuleInteractor();
                let presenter: Mock_ListRepoModulePresenter = Mock_ListRepoModulePresenter();
                let APIDataManager: Mock_ListRepoModuleAPIDataManager = Mock_ListRepoModuleAPIDataManager();
                let localDatamanager: Mock_ListRepoModuleLocalDatamanager = Mock_ListRepoModuleLocalDatamanager();
                
                beforeEach {
                    // given
                    interactor.presenter = presenter;
                    interactor.APIDataManager = APIDataManager;
                    interactor.localDatamanager = localDatamanager;
                    
                    // when
                    interactor.loadRepos("test", pulledToRefresh: false);
                }
                
                it("needs to call all the functions in the scenario") {
                    // then
                    
                    // APIDataManager
                    expect(APIDataManager.getReposWasCalled).to(beTrue());
                    expect(APIDataManager.getReposUser).to(equal("test"));
                    
                    // localDatamanager
                    expect(localDatamanager.deleteReposWasCalled).to(beTrue());
                    expect(localDatamanager.deleteReposUser).to(equal("test"));
                    
                    expect(localDatamanager.saveReposWasCalled).to(beTrue());
                    
                    expect(localDatamanager.getReposWasCalled).to(beTrue());
                    expect(localDatamanager.getReposUser).to(equal("test"));
                    
                    // presenter
                    expect(presenter.presentLoadingFromNetworkWasCalled).to(beTrue());
                    expect(presenter.presentLoadingFromNetworkPulledToRefresh).to(beFalse());
                    
                    expect(presenter.presentLoadingFromDatabaseWasCalled).to(beTrue());
                    expect(presenter.presentLoadingFromDatabasePulledToRefresh).to(beFalse());
                    
                    expect(presenter.presentReposWasCalled).to(beTrue());
                    expect(presenter.presentReposRepos).to(equal(localDatamanager.mockRepos));
                    expect(presenter.presentReposPulledToRefresh).to(beFalse());
                    
                    expect(presenter.presentErrorWasCalled).to(beFalse());
                }
            }
        }
    }
    
}
