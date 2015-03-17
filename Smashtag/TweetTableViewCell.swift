//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by pgore on 3/16/15.
//  Copyright (c) 2015 Pradnyesh Gore. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet:Tweet? {
        didSet{
            updateUI();
        }
    }
    
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI(){
        tweetTextLabel?.attributedText = nil;
        tweetScreenNameLabel.attributedText = nil;
        tweetProfileImageView?.image = nil;
        if let tweet = self.tweet{
            tweetTextLabel?.text = tweet.text;
            tweetScreenNameLabel?.text = "\(tweet.user)";
        }
        
        if let profileImageUrl =  tweet?.user.profileImageURL{
            if let imageData = NSData(contentsOfURL: profileImageUrl){
                // blocks main thread
                tweetProfileImageView.image = UIImage(data: imageData)
            }
        }
    }
}
