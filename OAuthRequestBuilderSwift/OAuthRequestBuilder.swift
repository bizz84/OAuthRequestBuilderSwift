//
//  OAuthRequestBuilder.swift
//  OAuthRequestBuilderSwift
//
//  Created by Andrea Bizzotto on 03/01/2015.
//  Copyright (c) 2015 Muse Visions. All rights reserved.
//

class OAuthRequestBuilder: NSObject {

    class func makeRequest(URL: NSURL, method: String, headers: [String : String], parameters: Dictionary<String, AnyObject>, dataEncoding : NSStringEncoding) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = method
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(dataEncoding))
        
        var nonOAuthParameters = parameters.filter { key, _ in !key.hasPrefix("oauth_") }
        
        if nonOAuthParameters.count > 0 {
            if request.HTTPMethod == "GET" || request.HTTPMethod == "HEAD" || request.HTTPMethod == "DELETE" {
                let queryString = nonOAuthParameters.urlEncodedQueryStringWithEncoding(dataEncoding)
                request.URL = URL.URLByAppendingQueryString(queryString)
                request.setValue("application/x-www-form-urlencoded; charset=\(charset)", forHTTPHeaderField: "Content-Type")
            }
            else {
                var error: NSError?
                if let jsonData: NSData = NSJSONSerialization.dataWithJSONObject(nonOAuthParameters, options: nil, error: &error)  {
                    request.setValue("application/json; charset=\(charset)", forHTTPHeaderField: "Content-Type")
                    request.HTTPBody = jsonData
                }
                else {
                    println(error!.localizedDescription)
                }
            }
        }
        return request
    }
}
