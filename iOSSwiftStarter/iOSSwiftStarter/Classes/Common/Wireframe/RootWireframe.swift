//
//  RootWireframe.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 24/12/15.
//
//

import Foundation
import UIKit

class RootWireframe: NSObject
{
    var window: UIWindow!;
    
    var listRepoModuleWireFrame: ListRepoModuleWireFrameProtocol = ListRepoModuleWireFrame();
    
    init(window: UIWindow)
    {
        super.init()
        // custom initialization
        self.window = window;
    }
    
    func installRootViewController()
    {
        // *** present first wireframe here
        let rootViewController: UINavigationController = Storyboards.Main.instantiateInitialViewController();
        self.window.rootViewController = rootViewController;
        
        listRepoModuleWireFrame.presentListRepoModuleModule(fromView: self.window.rootViewController!);
    }
}
