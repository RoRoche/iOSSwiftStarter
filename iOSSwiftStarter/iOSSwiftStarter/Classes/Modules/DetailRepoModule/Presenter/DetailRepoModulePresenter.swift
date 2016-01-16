//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation

class DetailRepoModulePresenter: DetailRepoModulePresenterProtocol, DetailRepoModuleInteractorOutputProtocol
{
    weak var view: DetailRepoModuleViewProtocol?
    var interactor: DetailRepoModuleInteractorInputProtocol?
    var wireFrame: DetailRepoModuleWireFrameProtocol?
    
    init() {}
    
    var detailItem: Repo?;
    
    func onViewDidLoad() {
        // Update the view.
        self.view!.showRepo(self.detailItem!);
    }
}