//
//  ProfileController.swift
//  Impact
//
//  Created by Connie Guan on 7/25/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseAuth

class ProfileController: UIViewController{
    
    var authHandle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let username = User.current.username
        usernameLabel.text = username
        
        authHandle = Auth.auth().addStateDidChangeListener() { [unowned self] (auth, user) in
            guard user == nil else { return }
            
            let loginViewController = UIStoryboard.initialViewController(for: .login)
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    deinit {
        if let authHandle = authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            assertionFailure("Error signing out: \(error.localizedDescription)")
        }
    }
    
    
}
