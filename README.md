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


License
-------------------------------------------------------
Copyright (c) 2015 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
