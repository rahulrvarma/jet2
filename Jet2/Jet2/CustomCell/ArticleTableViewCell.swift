//
//  ArticleTableViewCell.swift
//  Jet2
//
//  Created by Rahul Varma on 10/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var linkArticleURL: UITextView!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var constraintArticleImageHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintArticleUrllHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(article : Article){

        imgProfilePic.sd_setImage(with: URL(string: article.user.first!.avatar), placeholderImage: UIImage(named: "user"))
        
        lblTime.text = convertDateFormatter(date: article.createdAt)
        
        lblContent.text = article.content
        lblLikes.text =  article.likes.roundedWithAbbreviations + " Likes"
        lblComments.text = article.likes.roundedWithAbbreviations + " Comments"
        
        if article.media.count > 0 {
            constraintArticleImageHeight.constant = 135
            constraintArticleUrllHeight.constant = 30

            imgArticle.sd_setImage(with: URL(string: article.media.first!.image), placeholderImage: UIImage(named: "article-placeholder"))
            linkArticleURL.text = article.media.first?.url
            lblArticleTitle.text = article.media.first?.title
        }
        else{
            constraintArticleImageHeight.constant = 0
            constraintArticleUrllHeight.constant = 0
        }
        
        lblUsername.text = article.user.first?.name
        lblDesignation.text = article.user.first?.designation
    }

    
    public func convertDateFormatter(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        print(timeStamp)
        return timeStamp
    }
}
