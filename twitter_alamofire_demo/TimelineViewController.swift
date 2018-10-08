//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl ()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insertSubview(refreshControl, at: 0)
        getHomeTimeline()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        if let pic = tweets[indexPath.row].user?.profilePictureURL {
            cell.profilePhotoView.af_setImage(withURL: pic)
        }
        return cell
    }
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    func getHomeTimeline (){
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        
    }
    func didPullToRefresh (_ refreshController: UIRefreshControl){
        getHomeTimeline()
        refreshControl.endRefreshing()
        
        
    }
    
}
