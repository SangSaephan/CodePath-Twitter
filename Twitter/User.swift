//
//  User.swift
//  Twitter
//
//  Created by Sang Saephan on 2/22/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static var _currentUser: User?
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var backgroundImageUrl: URL?
    var tagline: String?
    var tweetCount: Int = 0
    var followingCount: Int = 0
    var followersCount: Int = 0
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundImageUrl = URL(string: backgroundUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
        tweetCount = (dictionary["statuses_count"] as? Int) ?? 0
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                
                let defaults = UserDefaults.standard
                if let userData = defaults.object(forKey: "currentUserData") as? NSData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
                
            }
            
            return _currentUser
            
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
    
}
