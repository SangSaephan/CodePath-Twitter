//
//  CurrentUserViewController.swift
//  Twitter
//
//  Created by Sang Saephan on 3/1/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class CurrentUserViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let backgroundUrl = User.currentUser!.backgroundImageUrl {
            backgroundImageView.setImageWith(backgroundUrl)
        } else {
            backgroundImageView.backgroundColor = UIColor(red: 58/255, green: 162/255, blue: 242/255, alpha: 0.8)
        }
        
        profileImageView.setImageWith(User.currentUser!.profileUrl!)
        nameLabel.text = User.currentUser!.name!
        screenNameLabel.text = "@\(User.currentUser!.screenName!)"
        tweetCountLabel.text = "\(User.currentUser!.tweetCount)"
        followingCountLabel.text = "\(User.currentUser!.followingCount)"
        followersCountLabel.text = "\(User.currentUser!.followersCount)"
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
