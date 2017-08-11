//
//  SettingsController.swift
//  Impact
//
//  Created by Connie Guan on 8/10/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuthUI

class SettingsController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SubmitController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        usernameTextField.text = User.current.username
        emailTextField.text = Auth.auth().currentUser?.email
        nameTextField.text = Auth.auth().currentUser?.displayName
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you would like to delete your account?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let action = UIAlertAction(title: "Delete", style: .default) { (UIAlertAction) in
            
            
            Auth.auth().currentUser?.delete(completion: { (err) in
                print(err?.localizedDescription as Any)
                
            })
            // dismiss popup
            self.dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Login", bundle: .main)
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        
        }
        
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        let ref = Database.database().reference().child("users").child(User.current.uid).updateChildValues(["username": usernameTextField.text!])
        
        Auth.auth().currentUser?.updateEmail(to: emailTextField.text!) { (error) in
            print(error)
        }
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = nameTextField.text
        changeRequest?.commitChanges { (error) in
            print(error)
        }
        
        self.navigationController?.popViewController(animated: true)
        if let username = usernameTextField.text {
            User.current.username = username
        }
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}


