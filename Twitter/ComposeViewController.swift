//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Sang Saephan on 3/2/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.setImageWith(User.currentUser!.profileUrl!)
        nameLabel.text = User.currentUser!.name!
        screenNameLabel.text = "@\(User.currentUser!.screenName!)"
        tweetTextView.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func tweetButtonPressed(_ sender: Any) {
        if tweetTextView.text != "" {
            let text = tweetTextView.text
            TwitterClient.sharedInstance?.postTweet(status: text!)
            
            dismiss(animated: true, completion: nil)
        }
    }

}
