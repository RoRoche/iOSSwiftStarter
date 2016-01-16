//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation
import UIKit

class ListRepoModuleWireFrame: ListRepoModuleWireFrameProtocol
{
    var detailWireframe : DetailRepoModuleWireFrameProtocol?;
    
    func presentListRepoModuleModule(fromView fromView: AnyObject)
    {
        // Generating module components
        let view: ListRepoModuleViewProtocol = Storyboards.Main.instantiateListRepoModuleView();
        let presenter: protocol<ListRepoModulePresenterProtocol, ListRepoModuleInteractorOutputProtocol> = ListRepoModulePresenter();
        let interactor: ListRepoModuleInteractorInputProtocol = ListRepoModuleInteractor();
        let APIDataManager: ListRepoModuleAPIDataManagerInputProtocol = ListRepoModuleAPIDataManager();
        let localDataManager: ListRepoModuleLocalDataManagerInputProtocol = ListRepoModuleLocalDataManager();
        let wireFrame: ListRepoModuleWireFrameProtocol = ListRepoModuleWireFrame();
        let detailRepoModuleWireFrame: DetailRepoModuleWireFrameProtocol = DetailRepoModuleWireFrame();
        
        // Connecting
        view.presenter = presenter;
        presenter.view = view;
        presenter.wireFrame = wireFrame;
        presenter.interactor = interactor;
        interactor.presenter = presenter;
        interactor.APIDataManager = APIDataManager;
        interactor.localDatamanager = localDataManager;
        
        wireFrame.detailWireframe = detailRepoModuleWireFrame;
        
        // Present
        if(fromView.isKindOfClass(UINavigationController)) {
            (fromView as! UINavigationController).setViewControllers([view as! UIViewController], animated: true);
        }
    }
    
    func presentDetailRepoModuleModule(fromView fromView: AnyObject, repo: Repo) {
        detailWireframe?.presentDetailRepoModuleModule(fromView: fromView, repo: repo);
    }
}