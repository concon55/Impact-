//
//  ProfileController.swift
//  Impact
//
//  Created by Connie Guan on 7/25/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseAuth

class ProfileController: UIViewController{
    
    @IBOutlet weak var quoteLabel: UILabel!
    var quotes = [Quotes]()
    
    var authHandle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
        
    override func viewWillAppear(_ animated: Bool) {
        
        if let path = Bundle.main.path(forResource: "quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //print("jsonData:\(jsonObj)")
                    let allQuotes = jsonObj["quotes"].arrayValue
                    for i in 0..<allQuotes.count{
                        let quote = Quotes.init(json: allQuotes[i])
                        quotes.append(quote)
                    }
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        let range = quotes.count 
        let random = Int(arc4random_uniform(UInt32(range)))
        quoteLabel.text = quotes[random].quote

        
        let username = User.current.username
        usernameLabel.text = username
        

    }
    
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            assertionFailure("Error signing out: \(error.localizedDescription)")
        }
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }

    }
    
    
}
