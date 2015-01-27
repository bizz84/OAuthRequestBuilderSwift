//
//  Semantics3RequestBuilder.swift
//  OAuthRequestBuilderSwift
//
//  Created by Andrea Bizzotto on 03/01/2015.
//  Copyright (c) 2015 Muse Visions. All rights reserved.
//

import UIKit
import Alamofire

enum Semantics3Endpoint: Int {
    case Testing
    case Production
    
    init(baseURL : String) {
        self = baseURL.rangeOfString("test") != nil ? .Testing : .Production
    }
}

enum Semantics3Router: URLRequestConvertible {
    
    // Cases
    case Products(query: String)
    case Categories(query: String)
    case Offers(query: String)
    
    // Initialisation
    static let baseURL : String!
    static let endpoint : Semantics3Endpoint!
    static let oauthClient : OAuthSwiftClient!
    
    init(baseURL : String, consumerKey: String, consumerSecret: String) {
        Semantics3Router.baseURL = baseURL
        Semantics3Router.endpoint = Semantics3Endpoint(baseURL: baseURL)
        Semantics3Router.oauthClient = OAuthSwiftClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
        self = Semantics3Router.Products(query: "")
    }
    
    var URLRequest: NSURLRequest {
        // enum derived values - using closure with a let to make it local to a function
        let (method: Alamofire.Method, path: String, parameters : [String: AnyObject]?) = {
            switch self {
            case .Products(let query):
                return (.GET, "products", ["q" : query])
            case .Categories(let query):
                return (.GET, "categories", ["q" : query])
            case .Offers(let query):
                return (.GET, "offers", ["q" : query])
            }
        }()
        
        let URL = NSURL(string: Semantics3Router.baseURL)!
        var URLWithPath = URL.URLByAppendingPathComponent(path)

        if Semantics3Router.endpoint == .Testing {
            let URLRequest = NSMutableURLRequest(URL: URLWithPath)
            URLRequest.setValue(Semantics3Router.oauthClient.credential.consumer_key, forHTTPHeaderField: "api_key")
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: parameters).0
        }
        else {
            
            let auth = OAuthSwiftClient.authorizationHeaderForMethod(method.rawValue,
                url: URLWithPath,
                parameters: parameters!,
                credential: Semantics3Router.oauthClient.credential)
            
            let URLRequest = OAuthRequestBuilder.makeRequest(URLWithPath,
                method: method.rawValue,
                headers: [ "Authorization" : auth ],
                parameters: parameters!,
                dataEncoding: dataEncoding)
            
            return URLRequest
        }
    }
}
