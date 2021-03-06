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
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification) , object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query!)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure?(error)
            })
            
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
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            failure(error)
            
        })
    }
    
    func retweet(id: Int, success: @escaping (Tweet)-> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("Retweet successful!")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("Retweet failure!")
        }
    }
    
    func unRetweet(id: Int, success: @escaping (Tweet)-> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("Unretweet successful!")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("Unretweet failure!")
        }
    }
    
    func favorite(id: Int, success: @escaping (Tweet)-> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("Favorited successful!")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("Favorited failure!")
        }
    }
    
    func unfavorite(id: Int, success: @escaping (Tweet)-> (), failure: @escaping (Error) -> ()) {
        
        post("/1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("Unfavorited successful!")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("Unfavorited failure! ")
        }
    }
    
    func postTweet(status: String) {
        post("1.1/statuses/update.json", parameters: ["status":status], progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            print("Tweet successful!")
        }) { (task: URLSessionDataTask?, error: Error!) in
            print(error.localizedDescription)
            print("Tweet failure!")
        }
    }
}
