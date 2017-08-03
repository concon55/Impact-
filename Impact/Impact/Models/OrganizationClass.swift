//
//  OrganizationClass.swift
//  Impact
//
//  Created by Connie Guan on 7/27/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Foundation
import SwiftyJSON

func ==(lhs: OrganizationClass, rhs: OrganizationClass) -> Bool {
    return lhs.categoryName == rhs.categoryName
}

struct OrganizationClass: Equatable{
    
    let charityName: String
    let description: String
    let donationURL: String
    let websiteUrl: String
    let categoryName: String
    let imageUrl: String
    let iconImage: String
    
    init(json: JSON) {
        self.categoryName = json["category"].stringValue
        self.charityName = json["name"].stringValue
        self.description = json["description"].stringValue
        self.donationURL = json["donationUrl"].stringValue
        self.websiteUrl = json["websiteUrl"].stringValue
        self.imageUrl = json["imageUrl"].stringValue
        self.iconImage = json["iconImage"].stringValue
    }
}





