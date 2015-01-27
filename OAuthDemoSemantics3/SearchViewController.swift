//
//  ViewController.swift
//  OAuthRequestBuilderSwift
//
//  Created by Andrea Bizzotto on 27/01/2015.
//  Copyright (c) 2015 Muse Visions. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

class SearchViewController: UIViewController {
    
    let router : Semantics3Router = {
        let TestEndpoint = "https://api.semantics3.com/test/v1/"
        let ProductionEndpoint = "https://api.semantics3.com/v1/"
        return Semantics3Router(baseURL: ProductionEndpoint,
            consumerKey: "INSERT_CUSTOMER_KEY_HERE",
            consumerSecret: "INSERT_CUSTOMER_SECRET_HERE")
        }()
    
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var textView : UITextView!

    func doSearch(searchBar: UISearchBar) {
        
        let query = searchBar.text
        
        // http://docs.semantics3.com/v1.0/docs/standard-filter-fields
        let request = Alamofire.request(Semantics3Router.Products(query: "{\"search\":\"\(query)\"}"))
        
        request.responseSwiftyJSON { (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error : NSError?) -> Void in
            
            self.textView.text = "\(json)"
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        doSearch(searchBar)
    }
}