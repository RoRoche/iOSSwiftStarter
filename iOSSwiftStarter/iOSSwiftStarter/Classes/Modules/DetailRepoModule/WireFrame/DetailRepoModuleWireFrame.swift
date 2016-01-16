//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation
import UIKit

class DetailRepoModuleWireFrame: DetailRepoModuleWireFrameProtocol
{
    func presentDetailRepoModuleModule(fromView fromView: AnyObject, repo: Repo)
    {
        // Generating module components
        let view: DetailRepoModuleViewProtocol = Storyboards.Main.instantiateDetailRepoModuleView();
        let presenter: protocol<DetailRepoModulePresenterProtocol, DetailRepoModuleInteractorOutputProtocol> = DetailRepoModulePresenter();
        let interactor: DetailRepoModuleInteractorInputProtocol = DetailRepoModuleInteractor();
        let APIDataManager: DetailRepoModuleAPIDataManagerInputProtocol = DetailRepoModuleAPIDataManager();
        let localDataManager: DetailRepoModuleLocalDataManagerInputProtocol = DetailRepoModuleLocalDataManager();
        let wireFrame: DetailRepoModuleWireFrameProtocol = DetailRepoModuleWireFrame();
        
        // Connecting
        view.presenter = presenter;
        presenter.view = view;
        presenter.wireFrame = wireFrame;
        presenter.interactor = interactor;
        interactor.presenter = presenter;
        interactor.APIDataManager = APIDataManager;
        interactor.localDatamanager = localDataManager;
        
        // Present view
        if(fromView.isKindOfClass(UINavigationController))
        {
            (fromView as! UINavigationController).pushViewController(view as! UIViewController, animated: true);
            presenter.detailItem = repo;
        }
    }
}