//
//  TweetViewController.swift
//  Twitter
//
//  Created by Bryan Rivas on 11/6/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelOnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetOnTap(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(TweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("unable to post tweet, error: \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if(tweetTextView.text.count > 0 && tweetTextView.text.count <= 140){
            countLabel.text = "\(tweetTextView.text.count)/140"
        }
        else if tweetTextView.text.count > 140{
            
            let startPos = tweetTextView.position(from: tweetTextView.beginningOfDocument, offset: 0)
            let endPos = tweetTextView.position(from: tweetTextView.endOfDocument, offset: -1)
            let thisRange = tweetTextView.textRange(from: startPos!, to: endPos!)
            tweetTextView.text = tweetTextView.text(in: thisRange!)!
            
        }
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
