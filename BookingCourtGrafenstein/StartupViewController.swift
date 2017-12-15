 //
//  StartupViewController.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 14.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

class StartupViewController: UIViewController {
    
    let startupLoginSegueIdentifier = "showLoginFromStartup"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        

        if (try? !hasCurrentUser())! {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2), execute: {
                self.performSegue(withIdentifier: self.startupLoginSegueIdentifier, sender:nil)
            })
        } else {
            // TODO: Show ClaendarViewController
        }
    }
    
    private func hasCurrentUser() throws -> Bool {
        
        if Auth.auth().currentUser != nil {
            try Auth.auth().signOut()
        }
        return false
    }
}
