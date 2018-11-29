//
//  DetailTweetViewController.swift
//  Switzzz
//
//  Created by Andre Campbell on 10/16/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailTweetViewController: UIViewController {
    
    var tweet: Tweet!

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            
            infoLabel.text = String(tweet.retweetedByUser?.screenName ?? "")
            if infoLabel.text != "" {
                infoLabel.text = infoLabel.text! + " retweeted"
            }
            profileImageView.af_setImage(withURL: tweet.user!.profilePictureURL!)
            nameLabel.text = tweet.user!.name
            usernameLabel.text = ("@" + tweet.user!.screenName!)
            tweetLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            retweetsLabel.text = String(tweet.retweetCount ?? 0)
            likesLabel.text = String(tweet.favoriteCount ?? 0)
            if tweet.retweeted! {
                replyButton.setImage(UIImage(named: "reply-icon"), for: UIControlState.normal)
                
            }
            
        }

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
