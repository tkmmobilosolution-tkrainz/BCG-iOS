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

class LoginViewController: ViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
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
                Globals.setUser(user: user)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func showErrorAlert(error: Error) {
        let errorMessage = error.localizedDescription
        let alertTitle = "Login-Fehler"
        var alertMessage = "Etwas ist schiefgelaufen. Bitte versuche es später erneut."
        if let er = AuthErrorCode(rawValue: error._code) {
            switch er {
            case .wrongPassword:
                alertMessage = "Das Passwort ist falsch. Bitte überprüfe deine Eingabe."
                print("wrong password")
            case .userNotFound:
                alertMessage = "Die angegebene Email-Adresse existiert nicht."
                print("userNotFound")
            case .networkError:
                alertMessage = "Netzwerk Fehler. Bitte überprüfe deine Internetverbindung."
                print("network error")
            default:
                alertMessage = "Etwas ist schiefgelaufen. Bitte versuche es später erneut."
                print(errorMessage)
            }
        }
        self.showCancelAlert(title: alertTitle, message: alertMessage)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            self.showCancelAlert(title: "Eingabe-Fehler", message: "Bitte gib deine Email-Adresse und dein Passwort ein.")
        } else if (!email.validEmailFormat()) {
            self.showCancelAlert(title: "Eingabe-Fehler", message: "Die Email Adresse entspricht nicht dem gewünschten Format.\n\nBeispiel: emailadress@provider.com")
        } else if (!password.validPasswordLength()) {
            self.showCancelAlert(title: "Eingabe-Fehler", message: "Dein Passwort muss mindestens acht Zeichen lang sein.")
        } else {
            loginFirebaseUser(email: email, password: password)
        }
    }
}
