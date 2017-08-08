//
//  InfoController.swift
//  Impact
//
//  Created by Connie Guan on 7/27/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class InfoController: UIViewController{
    
    var org: OrganizationClass?
    var organizations = [OrganizationClass]()
    var filtered = [OrganizationClass]()
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var infoDescriptionLabel: UILabel!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        websiteButton.setTitle(org?.websiteUrl, for: .normal)
        infoNameLabel.text = org?.charityName
        infoDescriptionLabel.text = org?.description
        infoDescriptionLabel.lineBreakMode = .byWordWrapping
        infoDescriptionLabel.numberOfLines = 0
        let imageUrl = org?.imageUrl
        infoImageView.af_setImage(withURL: URL(string: imageUrl!)!)
        
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toWebView"{
                let website = org?.websiteUrl
                let websiteController = segue.destination as! WebsiteController
                websiteController.websiteUrl = website!
                
            }
        }
    }

    
    

}

