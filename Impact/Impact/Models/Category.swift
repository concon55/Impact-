//
//  Category.swift
//  Impact
//
//  Created by Connie Guan on 7/27/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Category {
    
    let categoryName: String
    
    init(json: JSON) {
        self.categoryName = json["categoryDesc"].stringValue
    }
}
