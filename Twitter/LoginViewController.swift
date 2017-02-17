//
//  LoginViewController.swift
//  Twitter
//
//  Created by Sang Saephan on 2/17/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "YVxVpaBramhlqH85hMNyOS0sS", consumerSecret: "FqDnzSA9gD7AGK11ScgmJt8ukB3hj9dxoTgvwOiP8b6yEPRP2j")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("I got a token!")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error?) in
            print(error!.localizedDescription)
        })
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
