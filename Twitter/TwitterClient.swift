//
//  TwitterClient.swift
//  Twitter
//
//  Created by Sang Saephan on 2/22/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "YVxVpaBramhlqH85hMNyOS0sS", consumerSecret: "FqDnzSA9gD7AGK11ScgmJt8ukB3hj9dxoTgvwOiP8b6yEPRP2j")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("I got a token!")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error?) in
            print(error!.localizedDescription)
            self.loginFailure?(error!)
        })
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query!)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.loginSuccess?()
            
        }, failure: { (error: Error?) in
            print(error!.localizedDescription)
            self.loginFailure?(error!)
        })

    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let tweetDictionary = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetDictionary)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            failure(error)
            
        })
    }
    
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            print(error.localizedDescription)
            
        })
    }
}