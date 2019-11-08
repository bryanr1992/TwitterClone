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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
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

    @IBAction func likeTweet(_ sender: Any) {
    }
    
    @IBAction func retweet(_ sender: Any) {
    }
}
