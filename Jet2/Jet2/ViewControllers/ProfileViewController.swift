//
//  ProfileViewController.swift
//  Jet2
//
//  Created by Rahul Varma on 11/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    
    var user : User? = nil
    
    
    init(user : User) {
        self.user = user
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    fileprivate func loadUserProfileData() {
        // Do any additional setup after loading the view.
        
        if let userData = self.user
        {
            imgProfilePic.sd_setImage(with: URL(string: userData.avatar), placeholderImage: UIImage(named: "user"))
            lblUsername.text = userData.name
            lblDesignation.text = userData.designation
            lblCity.text = userData.city
            lblAbout.text = userData.about
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "User Profile"
        loadUserProfileData()

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
