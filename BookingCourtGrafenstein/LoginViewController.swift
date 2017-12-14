//
//  LoginViewController.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 14.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let loginRegisterSegueIdentifier = "showRegisterFromLogin"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}
