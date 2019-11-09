//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Bryan Rivas on 11/8/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var numberOfTweets: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var numberOfFollowers: UILabel!
    
    var tweetArray = [NSDictionary]()
    var user: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let myParams = ["screen_name":"Bryan Rivas"]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.user = self.tweetArray[0]["user"] as? NSDictionary
            
            var urlForImage = self.user["profile_image_url_https"] as? String
            urlForImage = urlForImage?.replacingOccurrences(of: "_normal.png", with: ".png")
            urlForImage = urlForImage?.replacingOccurrences(of: "_normal.jpg", with: ".jpg")
            //let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
            let imageUrl = URL(string: (urlForImage)!)
            let data = try? Data(contentsOf: imageUrl!)

            if let imageData = data{
                self.profileImage.image = UIImage(data: imageData)
                self.profileImage.contentMode = .scaleAspectFill
                self.profileImage.layer.masksToBounds = false
                self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
                self.profileImage.clipsToBounds = true
            }
            
            self.profileName.text = self.user["name"] as? String
            let optionalScreenName = self.user["screen_name"] as? String
            self.screenName.text = "@\(optionalScreenName!)"
            
            let followers = self.user["followers_count"] as? Int
            let followingNum = self.user["friends_count"] as? Int
            let tweetNumber = self.user["statuses_count"] as? Int
            
            self.numberOfTweets.text = "\(tweetNumber!) Tweets"
            self.following.text = "\(followingNum!) Following"
            self.numberOfFollowers.text = "\(followers!) Followers"
        
            
        }, failure: { (Error) in
            print("could not retrieve tweets")
        })
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
