//
//  iOSSwiftStarterAppDependencies.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 24/12/15.
//
//

import Foundation
import UIKit

class AppDependencies: NSObject
{
    var rootWireframe: RootWireframe!;
    
    class func initWithWindow(window: UIWindow) -> AppDependencies
    {

        let obj = AppDependencies();
        obj.configureDependencies(window);

        return obj;
    }

    func installRootViewController()
    {
        // *** present first wireframe here
        self.rootWireframe.installRootViewController();
    }

    func configureDependencies(window: UIWindow)
    {
        // -----
        // root classes
        self.rootWireframe = RootWireframe.init(window: window);
        // *** add datastore

        // *** module initialization
    }
}
