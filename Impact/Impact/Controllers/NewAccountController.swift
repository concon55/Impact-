//
//  NewAccountController.swift
//  Impact
//
//  Created by Connie Guan on 8/8/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit

class NewAccountController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewAccountController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
