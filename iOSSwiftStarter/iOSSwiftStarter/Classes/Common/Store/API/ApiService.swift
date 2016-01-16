//
//  ApiService.swift
//  iOSSwiftStarter
//
//  Created by Romain Rochegude on 11/12/2015.
//  Copyright © 2015 Romain Rochegude. All rights reserved.
//

import Alamofire

enum ApiService: URLRequestConvertible {
    static let baseURLString: String = "https://api.github.com";
    
    // MARK: API methods definitions
    
    case ListRepos(user: String, sort: ListReposSort?);
    
    // MARK: Parameters values for API methods
    
    enum ListReposSort {
        case DESC;
        case ASC;
        var value: String {
            switch self {
            case .ASC:
                return "asc";
            case .DESC:
                return "desc";
            }
        }
    }
    
    // MARK: Verb definition according to API method
    
    var method: Alamofire.Method {
        switch self {
        case .ListRepos:
            return .GET;
        }
    }
    
    // MARK: Path definition according to API method
    
    var path: (lastSegmentPath: String, parameters: [String: AnyObject]?) {
        switch self {
        case .ListRepos(let user, let sort) where sort != nil:
            return ("/users/\(user)/repos", ["sort": sort!.value]);
        case .ListRepos(let user, _):
            return ("/users/\(user)/repos", nil);
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: ApiService.baseURLString)!;
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path.lastSegmentPath));
        mutableURLRequest.HTTPMethod = method.rawValue;
        let encoding = Alamofire.ParameterEncoding.URL;
        
        return encoding.encode(mutableURLRequest, parameters: path.parameters).0;
    }
}