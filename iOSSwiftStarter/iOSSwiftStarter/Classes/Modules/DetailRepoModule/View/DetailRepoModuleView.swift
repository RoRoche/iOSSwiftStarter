//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import Foundation
import UIKit

class DetailRepoModuleView: UIViewController, DetailRepoModuleViewProtocol
{
    var presenter: DetailRepoModulePresenterProtocol?;
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        presenter!.onViewDidLoad();
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    // MARK: - ListRepoModuleViewInterface methods
    
    // *** implement view_interface methods here
    
    func showRepo(repo: Repo) {
        // Update the user interface for the detail item.
        self.title = repo.name;
        // viewController is visible
        if let label = self.detailDescriptionLabel
        {
            label.text = repo.desc;
        }
    }
    
    // MARK: - Button event handlers
    
    // ** handle UI events here
}