//
//  ArticleTableViewCell.swift
//  Jet2
//
//  Created by Rahul Varma on 10/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(article : Article){
//        imgProfilePic = article.media.first?.image
        lblUsername.text = article.user.first?.name
        lblDesignation.text = article.user.first?.designation
//        let formatter = RelativeDateTimeFormatter()
        
        lblTime.text = article.createdAt
//        imgArticle = article.user.first?.avatar
        lblContent.text = article.content
        lblArticleTitle.text = article.media.first?.title
        linkArticleURL.text = article.media.first?.image
        
        lblLikes.text =  article.likes.roundedWithAbbreviations + " Likes"
        
        lblComments.text = article.likes.roundedWithAbbreviations + " Comments"
    }
    
}
