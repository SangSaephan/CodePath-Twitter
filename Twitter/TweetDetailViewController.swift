//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Sang Saephan on 2/27/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetButtonOutlet: UIButton!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    
    var tweet: Tweet!
    var retweeted = false
    var favorited = false
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = tweet.name!
        screenNameLabel.text = "@\(tweet.screenName!)"
        tweetLabel.text = tweet.text!
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoriteCountLabel.text = "\(tweet.favoritesCount)"
        
        // Set the format for the timestamp
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let dateString = formatter.string(from: tweet.timestamp!)
        timestampLabel.text = dateString
        
        profileImageView.setImageWith(tweet.profileImageUrl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweetButtonPressed(_ sender: Any) {
        if retweeted == false {
            retweetButtonOutlet.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
        } else {
            retweetButtonOutlet.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if favorited == false {
            favoriteButtonOutlet.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
        } else {
            favoriteButtonOutlet.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
        }
    }

}
