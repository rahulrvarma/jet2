//
//  UserTableViewCell.swift
//  Jet2
//
//  Created by Rahul Varma on 11/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user : User){
        
        imgProfilePic.sd_setImage(with: URL(string: user.avatar), placeholderImage: UIImage(named: "user"))
        lblUsername.text = user.name
        lblDesignation.text = user.designation
        lblCity.text = user.city

    }
    
}
