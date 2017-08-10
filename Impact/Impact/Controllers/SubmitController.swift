//
//  SubmitController.swift
//  Impact
//
//  Created by Connie Guan on 8/2/17.
//  Copyright © 2017 Connie Guan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseAuth

class SubmitController: UIViewController{

    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
   
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SubmitController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let ref = Database.database().reference()
        ref.child("posts").child(User.current.uid).childByAutoId().setValue(nameTextField.text)
        ref.child("posts").child(User.current.uid).childByAutoId().setValue(urlTextField.text)
        ref.child("posts").child(User.current.uid).childByAutoId().setValue(descriptionTextField.text)
        
        let alertController = UIAlertController(title: "Submitted", message: "Thank you for your recommendation", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .default) { (UIAlertAction) in
            
            // For Dismissing the Popup
            self.dismiss(animated: true, completion: nil)
            
            // Dismiss current Viewcontroller and go back 
            self.navigationController?.popViewController(animated: true)
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
