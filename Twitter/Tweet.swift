//
//  Tweet.swift
//  Twitter
//
//  Created by Sang Saephan on 2/22/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var name: String?
    var screenName: String?
    var profileImageUrl: URL?
    var backgroundImageUrl: URL?
    var userTweets : Int = 0
    var userFollowing: Int = 0
    var userFollowers: Int = 0
    var id: Int?
    
    init(dictionary: NSDictionary) {
        let user = dictionary["user"] as? NSDictionary
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        id = (dictionary["id"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            timestamp = formatter.date(from: timestampString)
        }
        
        name = user?["name"] as? String
        screenName = user?["screen_name"] as? String
        userTweets = (user?["statuses_count"] as? Int) ?? 0
        userFollowing = (user?["friends_count"] as? Int) ?? 0
        userFollowers = (user?["followers_count"] as? Int) ?? 0
        profileImageUrl = URL(string: (user?["profile_image_url"] as? String)!)
        let backgroundUrlString = user?["profile_background_image_url"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundImageUrl = URL(string: backgroundUrlString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
