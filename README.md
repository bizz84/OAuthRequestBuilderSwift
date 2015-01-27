OAuth Authentication with Custom Headers in Swift
=========================

This project shows how to perform one-legged authorization with OAuth in Swift as described in [OAuth 1.0a (one-legged)](https://github.com/Mashape/mashape-oauth/blob/master/FLOWS.md#oauth-10a-one-legged).
This is useful as one-legged authorization is the authentication method required by a number of common service APIs such as [Twitter](https://dev.twitter.com/oauth/overview/authentication-by-api-family) and [Flickr](https://www.flickr.com/services/api/auth.oauth.html).

[OAuthSwift](https://github.com/dongri/OAuthSwift) already provides a [working client](https://github.com/dongri/OAuthSwift/blob/master/OAuthSwift/OAuthSwiftClient.swift) 
for creating and sending signed URL requests, however it does not provide a way to independently generate OAuth-signed URL requests
AND send them with the networking library of choice (such as Alamofire or NSURLConnection).

Here we extend the work already done in [OAuthSwift](https://github.com/dongri/OAuthSwift) and show how to:
* Sign URL requests with OAuth authorization headers
* Send the signed requests with [Alamofire](https://github.com/Alamofire/Alamofire)

We use the [Semantics3](https://www.semantics3.com/) e-commerce search API as the reference API for this project.

Usage
-------------------------------------------------------

The Semantics3 APIs are accessible through the following Testing and Production endpoints:
* https://api.semantics3.com/test/v1/
* https://api.semantics3.com/v1/

The demo code includes support for product search queries such as this:

https://api.semantics3.com/v1/products?q={"search":"iphone"}

By using the [Semantics3Router enum](https://github.com/bizz84/OAuthRequestBuilderSwift/blob/master/OAuthDemoSemantics3/Semantics3Router.swift) we can make the request above with the following call:

```swift
let request = Alamofire.request(Semantics3Router.Products(query: "{\"search\":\"\(query)\"}"))
        
request.responseSwiftyJSON { (request: NSURLRequest, response: NSHTTPURLResponse?, json: JSON, error : NSError?) -> Void in
            
    println("\(json)")
}
```

Implementation
-------------------------------------------------------

Under the hood, we can use OAuthSwiftClient to build the authorization header string for our URL request like so:
```swift
// 1. Build authorization header string
let auth = OAuthSwiftClient.authorizationHeaderForMethod(method.rawValue,
    url: URLWithPath,
    parameters: parameters!,
    credential: Semantics3Router.oauthClient.credential)
```
then pass this to the [OAuthRequestBuilder](https://github.com/bizz84/OAuthRequestBuilderSwift/blob/master/OAuthRequestBuilderSwift/OAuthRequestBuilder.swift) class:

```swift
// 2. Make URL request
let URLRequest = OAuthRequestBuilder.makeRequest(URLWithPath,
    method: method.rawValue,
    headers: [ "Authorization" : auth ],
    parameters: parameters!,
    dataEncoding: dataEncoding)
```

Docs
-------------------------------------------------------
The full Semantics3 API documentation can be found [here](http://docs.semantics3.com/v1.0/docs/about-the-api).

Dependencies
-------------------------------------------------------
* [Alamofire](https://github.com/Alamofire/Alamofire) Elegant HTTP Networking in Swift
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) The better way to deal with JSON data in Swift
* [Alamofire-SwiftyJSON](https://github.com/SwiftyJSON/Alamofire-SwiftyJSON) This is a convenience wrapper to parse JSON with SwiftyJSON from a server response, suggested [here](https://github.com/Alamofire/Alamofire/issues/57)
* [OAuthSwift](https://github.com/dongri/OAuthSwift) Swift based OAuth library for iOS

Notes
-------------------------------------------------------
At the time of writing, the OAuthSwift library could not be compiled as a cocoapod due to [this issue](https://github.com/dongri/OAuthSwift/issues/20). This project uses an older version of OAuthSwift that does not require CommonCrypto.

In order to use the Semantics3 API when running the project, it is necessary to sign up for a (free) account and obtain the required customer keys:
https://www-dashboard.semantics3.com/signup

License
-------------------------------------------------------
Copyright (c) 2015 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
