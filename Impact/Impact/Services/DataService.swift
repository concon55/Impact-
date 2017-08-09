//
//  DataService.swift
//  Impact
//
//  Created by Connie Guan on 8/9/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift

let DB_BASE = Database.database().reference()

class DataService {
    private var _keyChain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var keyChain: KeychainSwift {
        get {
            return _keyChain
        } set {
            _keyChain = newValue
        }
    }
}
