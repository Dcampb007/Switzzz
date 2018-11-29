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
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let ntweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(ntweet.text)")
                    self.tweet.retweeted = false
                    // This is a hack, for some reason it's not decreasing when I unretweet
                    self.retweetLabel.text = String(ntweet.retweetCount! - 1)
                }
            }
        }
        else {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let ntweet = tweet {
                    print("Successfully rewtweeting the following Tweet: \n\(ntweet.text)")
                   // var count = ntweet.favoriteCount! + 1
                    self.tweet.retweeted = true
                    self.retweetLabel.text = String(ntweet.retweetCount!)
                }
            }
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited! {
            print("true")
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(ntweet.text)")
                   // let count = ntweet.favoriteCount! - 1
                    self.tweet.favorited = false
                    self.favoriteLabel.text = String(ntweet.favoriteCount!)
                }
            }
        }
        else {
            print("false")
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(ntweet.text)")
                   // let count = ntweet.favoriteCount! + 1
                    self.tweet.favorited = true
                    self.favoriteLabel.text = String(ntweet.favoriteCount!)
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
