//
//  TweetCell.swift
//  Switzzz
//
//  Created by Andre Campbell on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var tweet: Tweet!{
        
        didSet{
            tweetLabel.text = tweet.text
            nameLabel.text = tweet.user!.name
            let scr = "@" + tweet.user!.screenName!
            usernameLabel.text = scr
            createdAtLabel.text = tweet.createdAtString
            if let count = tweet.retweetCount {
                retweetLabel.text = String(count)
            }
            else {
                retweetLabel.text = String(0)
            }
            if let cnt = tweet.favoriteCount{
                
                favoriteLabel.text = String(cnt)
            }
            else
            {
                favoriteLabel.text = String(0)
                
            }
            
        }
    }
    
    @IBAction func didTapReply(_ sender: Any) {
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted! {
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    var count = tweet.favoriteCount! - 1
                    self.favoriteLabel.text = String(count)
                }
            }
        }
        else {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    var count = tweet.favoriteCount! + 1
                    self.favoriteLabel.text = String(count)
                }
            }
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited! {
            print("true")
            APIManager.shared.unFavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    
                    print("Successfully favorited the following Tweet: \n\(ntweet.text)")
                    let count = ntweet.favoriteCount! - 1
                    self.favoriteLabel.text = String(count)
                }
            }
        }
        else {
            print("false")
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet: \n\(ntweet.text)")
                    let count = ntweet.favoriteCount! + 1
                    self.favoriteLabel.text = String(count)
                }
            }
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
