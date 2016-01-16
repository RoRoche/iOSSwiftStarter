//
//  AbstractQueryNotification.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 14/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import Foundation

public class AbstractQueryNotification {
    
    private struct UserInfo {
        static let Results: String = "results";
        static let Error: String = "error";
        static let IsCancelled: String = "isCancelled";
    }
    
    public class func buildUserInfoSuccess<T where T: AnyObject>(results: T) -> [NSObject: AnyObject] {
        let userInfo: [String: AnyObject] = [
            UserInfo.Results:results
        ];
        
        return userInfo;
    }
    
    public class func buildUserInfoFailure(error: NSError, isCancelled: Bool) -> [NSObject: AnyObject] {
        let userInfo: [String: AnyObject] = [
            UserInfo.Error: error,
            UserInfo.IsCancelled: isCancelled
        ];
        
        return userInfo;
    }
    
    private class func getUserInfoForKey<T>(notification: NSNotification, key: String) -> T? {
        let userInfo: [NSObject: AnyObject] = notification.userInfo as [NSObject: AnyObject]!;
        
        var ret: T? = nil;
        
        if let value = userInfo[key] {
            ret = value as? T
        }
        
        return ret;
    }
    
    public class func results<T>(notification: NSNotification) -> T? {
        return getUserInfoForKey(notification, key: UserInfo.Results);
    }
    
    public class func error(notification: NSNotification) -> NSError? {
        return getUserInfoForKey(notification, key: UserInfo.Error);
    }
    
    public class func isCancelled(notification: NSNotification) -> Bool? {
        return getUserInfoForKey(notification, key: UserInfo.IsCancelled);
    }
}
