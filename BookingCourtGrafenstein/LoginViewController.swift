//
//  LoginViewController.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 14.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func loginFirebaseUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                self.showErrorAlert(error: error)
                return
            }
            
            if let user = user {
                self.getUserWithId(uuid: user.uid)
            }
        })
    }
    
    private func getUserWithId(uuid: String) {
        let reference = Database.database().reference()
        reference.child("users").child(uuid).observeSingleEvent(of:.value, with: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let user = User(dictionary: userDictionary, uuid: uuid)
                print(user.firstname, user.lastname)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func showErrorAlert(error: Error) {
        let errorMessage = error.localizedDescription
        if let er = AuthErrorCode(rawValue: error._code) {
            switch er {
            case .wrongPassword:
                print("wrong password")
            case .userNotFound:
                print("userNotFound")
            case .networkError:
                print("network error")
            default:
                print(errorMessage)
            }
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            // TODO: show alert no email or password
            return
        }
        
        if (!email.validEmailFormat()) {
            // TODO: show wrong email format
        } else if (!password.validPasswordLength()) {
            // TODO: show less password chars
        } else {
            loginFirebaseUser(email: email, password: password)
        }
    }
}
