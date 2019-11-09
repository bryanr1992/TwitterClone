//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Bryan Rivas on 10/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var liked: Bool = false
    var retweeted: Bool = false
    var tweetId: Int!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var embeddedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLikedTweet(_ isLiked: Bool){
        liked = isLiked
        if(liked){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }

    @IBAction func likeTweet(_ sender: Any) {
        let toBeLiked = !liked
        
        if(toBeLiked){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success: {
                self.setLikedTweet(true)
            }, failure: { (error) in
                print("Unable to favorite tweet: \(error)")
            })
            
            liked = true
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetId, success: {
                self.setLikedTweet(false)
            }, failure: { (error) in
                print("Unable to unfavorite tweet: \(error)")
            })
            
            liked = false
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        
        if(toBeRetweeted){
            TwitterAPICaller.client?.retweet(tweetID: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("unable to retweet \(error)")
            })
        }
    }
}
