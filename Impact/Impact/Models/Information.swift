//
//  Information.swift
//  Impact
//
//  Created by Connie Guan on 7/27/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Information {
    
    let charityName: String
    let description: String
    let ein: String
    
    init(json: JSON) {
        self.charityName = json["charityName"].stringValue
        self.description = json["missionStatement"].stringValue
        self.ein = json["ein"].stringValue
    }
}
