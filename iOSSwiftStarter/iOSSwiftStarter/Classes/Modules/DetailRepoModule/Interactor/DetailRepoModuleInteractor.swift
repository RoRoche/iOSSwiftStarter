//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation

class DetailRepoModuleInteractor: DetailRepoModuleInteractorInputProtocol
{
    weak var presenter: DetailRepoModuleInteractorOutputProtocol?
    var APIDataManager: DetailRepoModuleAPIDataManagerInputProtocol?
    var localDatamanager: DetailRepoModuleLocalDataManagerInputProtocol?
    
    init() {}
}