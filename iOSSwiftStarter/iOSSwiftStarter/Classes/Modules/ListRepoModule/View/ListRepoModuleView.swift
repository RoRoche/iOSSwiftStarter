//
// Created by VIPER
// Copyright (c) 2015 VIPER. All rights reserved.
//

import UIKit
import Kugel
import CoreStore
import Hakuba
import Async
import StatefulViewController

class ListRepoModuleView: UIViewController, StatefulViewController, ListRepoModuleViewProtocol
{
    var presenter: ListRepoModulePresenterProtocol?;
    
    enum ViewState {
        case Empty;
        case Error;
        case Loading;
        case Content;
        
        var value: String {
            switch self {
            case .Empty:
                return "Empty";
            case .Error:
                return "Error";
            case .Loading:
                return "Loading";
            case .Content:
                return "Content";
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var viewLoading: UIView!
    
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var labelEmpty: UILabel!
    @IBOutlet weak var labelLoading: UILabel!
    
    // MARK: - Members
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl();
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh");
        refreshControl.addTarget(self, action: "onPulledToRefresh:", forControlEvents: UIControlEvents.ValueChanged);
        
        return refreshControl;
    }();
    
    var stateMachine: ViewStateMachine? = nil;
    var data: Array<Repo> = [];
    private var hakuba: Hakuba!;
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.synthesizeController();
        
        self.presenter?.loadRepos("RoRoche", pulledToRefresh: false);
    }
    
    override func viewWillAppear(animated: Bool) {
        hakuba.deselectAllCells();
        super.viewWillAppear(animated);
    }
    
    // MARK: - Synthesize
    
    func synthesizeController() {
        self.tableView.addSubview(self.refreshControl);
        
        // StatefulViewController
        
        stateMachine = ViewStateMachine(view: tableView);
        // Add states
        stateMachine[ViewState.Loading.value] = viewLoading;
        stateMachine[ViewState.Error.value] = viewError;
        stateMachine[ViewState.Empty.value] = viewEmpty;
        stateMachine[ViewState.Content.value] = tableView;
        
        // configure Hakuba
        hakuba = Hakuba(tableView: tableView);
        hakuba.registerNibForCellClass(RepoCell);
        hakuba.cellEditable = false;
    }
    
    // MARK: - ListRepoModuleViewProtocol
    func showLoadingFromNetwork(pulledToRefresh: Bool) {
        self.labelLoading.text = "Loading data from network...";
        
        if(!pulledToRefresh) {
            stateMachine.transitionToState(.View(ViewState.Loading.value), animated: true);
        }
    }
    
    func showLoadingFromDatabase(pulledToRefresh: Bool) {
        self.labelLoading.text = "Loading data from database...";
        
        if(!pulledToRefresh) {
            stateMachine.transitionToState(.View(ViewState.Loading.value), animated: true);
        }
    }
    
    func showRepos(repos: Array<Repo>, pulledToRefresh: Bool) {
        Async.main {
            self.data = repos;
            self.resetRepoCellModels(pulledToRefresh);
        }
    }
    
    func showError(error: NSError) {
        Async.main {
            self.labelError.text = "An error occurred...";
            self.stateMachine.transitionToState(.View(ViewState.Error.value), animated: true);
        }
    }
    
    // MARK: - Selectors
    
    @IBAction func onClickRetry(sender: AnyObject) {
        self.presenter?.loadRepos("RoRoche", pulledToRefresh: false);
    }
    
    // MARK: - User interactions
    
    func onPulledToRefresh(sender: AnyObject) {
        self.presenter?.loadRepos("RoRoche", pulledToRefresh: true);
    }
    
    // MARK: - Table view specific job
    
    func resetRepoCellModels(pulledToRefresh: Bool) {
        var cellModels: Array<RepoCellModel> = Array<RepoCellModel>();
        
        for repo: Repo in self.data {
            let cellModel: RepoCellModel = RepoCellModel(avatarUrl: repo.avatarUrl!, name: repo.name!) { _ in
                self.presenter?.presentDetailRepoModuleModule(repo);
                
                self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: true);
            };
            
            cellModels.append(cellModel);
        }
        
        self.hakuba[0].reset(cellModels)
            .slide(.Fade);
        
        if(self.data.count > 0) {
            stateMachine.transitionToState(.View(ViewState.Content.value), animated: true);
        } else {
            stateMachine.transitionToState(.View(ViewState.Empty.value), animated: true);
        }
        
        if(pulledToRefresh) {
            self.refreshControl.endRefreshing();
        }
    }
    
    // MARK: - StatefulViewController
    
    func hasContent() -> Bool {
        return (self.data.count > 0);
    }
    
    func handleErrorWhenContentAvailable(error: ErrorType) {
    }
}