//
//  Kugel.swift
//  Kugel
//
//  Created by Loïs Di Qual on 7/9/15.
//  Copyright (c) 2015 Scoop, Inc. All rights reserved.
//

import Foundation

public typealias KugelToken = NSObjectProtocol

public class Kugel {
    
    private static let notificationCenter = NSNotificationCenter.defaultCenter()
    
    // Publish
    
    public class func publish(notification: NSNotification) {
        notificationCenter.postNotification(notification)
    }
    
    public class func publish(name: String, object: AnyObject, userInfo: [NSObject: AnyObject]) {
        notificationCenter.postNotificationName(name, object: object, userInfo: userInfo)
    }
    
    public class func publish(name: String, object: AnyObject) {
        notificationCenter.postNotificationName(name, object: object)
    }
    
    public class func publish(name: String) {
        notificationCenter.postNotificationName(name, object: nil)
    }
    
    // Subscribe
    
    public class func subscribe(name: String, block: (NSNotification -> Void)) -> KugelToken {
        return notificationCenter.addObserverForName(name, object: nil, queue: nil) { notification in
            block(notification)
        }
    }
    
    public class func subscribe(observer: AnyObject, name: String, selector: Selector) {
        return notificationCenter.addObserver(observer, selector: selector, name: name, object: nil)
    }
    
    public class func subscribe(observer: AnyObject, _ notifications: [String: Selector]) {
        for (name, selector) in notifications {
            subscribe(observer, name: name, selector: selector)
        }
    }
    
    // Unsubscribe
    
    public class func unsubscribeToken(token: KugelToken) {
        notificationCenter.removeObserver(token)
    }
    
    public class func unsubscribe(observer: AnyObject, name: String) {
        return notificationCenter.removeObserver(observer, name: name, object: nil)
    }
    
    public class func unsubscribe(observer: AnyObject, _ names: [String]) {
        for name in names {
            unsubscribe(observer, name: name)
        }
    }
    
    public class func unsubscribeAll(observer: AnyObject) {
        notificationCenter.removeObserver(observer)
    }
}

