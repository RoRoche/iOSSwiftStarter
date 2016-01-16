//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation
import UIKit

class ListRepoModulePresenter: ListRepoModulePresenterProtocol, ListRepoModuleInteractorOutputProtocol
{
    init() {}
    
    // MARK: - ListRepoModulePresenterProtocol
    
    weak var view: ListRepoModuleViewProtocol?
    var interactor: ListRepoModuleInteractorInputProtocol?
    var wireFrame: ListRepoModuleWireFrameProtocol?
    
    func loadRepos(user: String, pulledToRefresh: Bool) {
        interactor?.loadRepos(user, pulledToRefresh: pulledToRefresh);
    }
    
    func presentDetailRepoModuleModule(repo: Repo) {
        let navigationViewController = (self.view as! UIViewController).navigationController;
        self.wireFrame?.presentDetailRepoModuleModule(fromView: navigationViewController!, repo: repo);
    }
    
    // MARK: - ListRepoModuleInteractorOutputProtocol
    
    func presentLoadingFromNetwork(pulledToRefresh: Bool) {
        view?.showLoadingFromNetwork(pulledToRefresh);
    }
    
    func presentLoadingFromDatabase(pulledToRefresh: Bool) {
        view?.showLoadingFromDatabase(pulledToRefresh);
    }
    
    func presentRepos(repos: Array<Repo>, pulledToRefresh: Bool) {
        view?.showRepos(repos, pulledToRefresh: pulledToRefresh);
    }
    
    func presentError(error: NSError) {
        view?.showError(error);
    }
}