//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Sang Saephan on 2/22/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl.addTarget(self, action: #selector(TweetsViewController.refreshControlAction), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        refreshControlAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshControlAction()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.profileImageButtonOutlet.tag = indexPath.row
        cell.configureCell(tweet: tweets[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet: Tweet!
        tweet = tweets[indexPath.row]
        
        performSegue(withIdentifier: "TweetDetailsPage", sender: tweet)
    }
    
    // Pull to refresh action
    func refreshControlAction() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Set title for back button
        let backButton = UIBarButtonItem()
        backButton.title = "Home"
        navigationItem.backBarButtonItem = backButton
        
        if segue.identifier == "TweetDetailsPage" {
            
            if let destination = segue.destination as? TweetDetailViewController {
                if let tweet = sender as? Tweet {
                    destination.tweet = tweet
                }
            }
        }
        
        if segue.identifier == "User" {
            
            let button = sender as? UIButton
            let tweet = tweets[(button?.tag)!]
            
            if let destination = segue.destination as? UserViewController {
                destination.tweet = tweet
            }
        }
    }
    

}
