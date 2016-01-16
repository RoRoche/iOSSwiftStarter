//
//  iOSSwiftStarterAppDelegate.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 24/12/15.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var dependencies: AppDependencies?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // initialize window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds);
        self.window?.backgroundColor = UIColor.whiteColor();
        
        // initialize dependencies
        self.dependencies = AppDependencies.initWithWindow(self.window!);
        
        // adding RootViewController
        self.dependencies?.installRootViewController();
        
        self.window!.makeKeyAndVisible();
        
        return true
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}
