//
//  SearchSummary.swift
//  Impact
//
//  Created by Connie Guan on 7/27/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SearchSummary {
    
    let charityName: String
    let missionStatement: String
    let ein: String
    let donationURL: String
    let acceptingDonations: Int
    let category: String
    let website: String
    
    init(json: JSON) {
        self.charityName = json["charityName"].stringValue
        self.missionStatement = json["missionStatement"].stringValue
        self.ein = json["ein"].stringValue
        self.donationURL = json["donationUrl"].stringValue
        self.acceptingDonations = json["acceptingDonations"].intValue
        self.category = json["category"].stringValue
        self.website = json["website"].stringValue
        
    }
}
