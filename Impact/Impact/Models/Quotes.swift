//
//  Quotes.swift
//  Impact
//
//  Created by Connie Guan on 8/11/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Quotes{
    
    let quote: String
    
    
    init(json: JSON) {
        self.quote = json["quote"].stringValue
    }
}
