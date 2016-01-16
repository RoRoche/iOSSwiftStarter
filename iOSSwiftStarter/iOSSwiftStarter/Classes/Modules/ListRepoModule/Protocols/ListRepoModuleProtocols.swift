//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation

protocol ListRepoModuleViewProtocol: class
{
    var presenter: ListRepoModulePresenterProtocol? { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    func showLoadingFromNetwork(pulledToRefresh: Bool);
    func showLoadingFromDatabase(pulledToRefresh: Bool);
    func showRepos(repos: Array<Repo>, pulledToRefresh: Bool);
    func showError(error: NSError);
}

protocol ListRepoModuleWireFrameProtocol: class
{
    func presentListRepoModuleModule(fromView fromView: AnyObject);
    /**
     * Add here your methods for communication PRESENTER -> WIREFRAME
     */
    var detailWireframe : DetailRepoModuleWireFrameProtocol? { get set };
    func presentDetailRepoModuleModule(fromView fromView: AnyObject, repo: Repo);
}

protocol ListRepoModulePresenterProtocol: class
{
    var view: ListRepoModuleViewProtocol? { get set };
    var interactor: ListRepoModuleInteractorInputProtocol? { get set };
    var wireFrame: ListRepoModuleWireFrameProtocol? { get set };
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */
    func loadRepos(user: String, pulledToRefresh: Bool);
    func presentDetailRepoModuleModule(repo: Repo);
}

protocol ListRepoModuleInteractorOutputProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> PRESENTER
     */
    func presentLoadingFromNetwork(pulledToRefresh: Bool);
    func presentLoadingFromDatabase(pulledToRefresh: Bool);
    func presentRepos(repos: Array<Repo>, pulledToRefresh: Bool);
    func presentError(error: NSError);
}

protocol ListRepoModuleInteractorInputProtocol: class
{
    var presenter: ListRepoModuleInteractorOutputProtocol? { get set }
    var APIDataManager: ListRepoModuleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ListRepoModuleLocalDataManagerInputProtocol? { get set }
    /**
     * Add here your methods for communication PRESENTER -> INTERACTOR
     */
    func loadRepos(user: String, pulledToRefresh: Bool);
}

enum ListRepoModuleAPIDataManagerGetReposResult {
    case Success(repos: Array<RepoDTO>);
    case Failure(error: NSError);
}

protocol ListRepoModuleAPIDataManagerInputProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
     */
    func getRepos(user: String, completionHandler: (ListRepoModuleAPIDataManagerGetReposResult) -> Void);
}

enum ListRepoModuleLocalDataManagerDeleteReposResult {
    case Success(deleted: Int);
    case Failure(error: NSError);
}

enum ListRepoModuleLocalDataManagerSaveReposResult {
    case Success();
    case Failure(error: NSError);
}

enum ListRepoModuleLocalDataManagerGetReposResult {
    case Success(repos: Array<Repo>);
    case Failure(error: NSError);
}

protocol ListRepoModuleLocalDataManagerInputProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
     */
    
    func deleteRepos(user: String, completionHandler: (ListRepoModuleLocalDataManagerDeleteReposResult) -> Void);
    func saveRepos(repos: Array<RepoDTO>, completionHandler: (ListRepoModuleLocalDataManagerSaveReposResult) -> Void);
    func getRepos(user: String, completionHandler: (ListRepoModuleLocalDataManagerGetReposResult) -> Void);
}
