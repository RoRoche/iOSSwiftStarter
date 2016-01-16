//
//  DataStoreManager.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 14/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import UIKit
import CoreStore

final class DataStoreManager: NSObject {
    
    // MARK: - Singleton set up
    
    static let sharedInstance = DataStoreManager();
    
    private override init() {
        super.init();
        
        // This prevents others from using the default '()' initializer for this class.
        
        self.synthesizeDataStoreManager();
    }
    
    // MARK: - CoreStore specific job
    
    private static let fileName: String = "iOSSwiftStarter.sqlite";
    
    let dataStack = DataStack();
    
    private func synthesizeDataStoreManager() {
        try! self.dataStack.addSQLiteStoreAndWait(fileName: DataStoreManager.fileName);
    }
}
