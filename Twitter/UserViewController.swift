//
//  UserViewController.swift
//  Twitter
//
//  Created by Sang Saephan on 3/2/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let backgroundUrl = tweet.backgroundImageUrl {
            backgroundImageView.setImageWith(backgroundUrl)
        } else {
            backgroundImageView.backgroundColor = UIColor(red: 58/255, green: 162/255, blue: 242/255, alpha: 0.8)
        }
        
        profileImageView.setImageWith(tweet.profileImageUrl!)
        nameLabel.text = tweet.name!
        screenNameLabel.text = "@\(tweet.screenName!)"
        tweetCountLabel.text = "\(tweet.userTweets)"
        followingCountLabel.text = "\(tweet.userFollowing)"
        followersCountLabel.text = "\(tweet.userFollowers)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
