//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation

protocol DetailRepoModuleViewProtocol: class
{
    var presenter: DetailRepoModulePresenterProtocol? { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    func showRepo(repo: Repo);
}

protocol DetailRepoModuleWireFrameProtocol: class
{
    func presentDetailRepoModuleModule(fromView fromView: AnyObject, repo: Repo);
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol DetailRepoModulePresenterProtocol: class
{
    var view: DetailRepoModuleViewProtocol? { get set }
    var interactor: DetailRepoModuleInteractorInputProtocol? { get set }
    var wireFrame: DetailRepoModuleWireFrameProtocol? { get set }
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */
    
    var detailItem: Repo? { get set }
    func onViewDidLoad();
}

protocol DetailRepoModuleInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol DetailRepoModuleInteractorInputProtocol: class
{
    var presenter: DetailRepoModuleInteractorOutputProtocol? { get set }
    var APIDataManager: DetailRepoModuleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: DetailRepoModuleLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol DetailRepoModuleAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol DetailRepoModuleLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
