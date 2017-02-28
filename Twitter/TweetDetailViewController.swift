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
    
    var tweet: Tweet!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
