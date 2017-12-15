//
//  ViewController.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 14.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    public func showCancelAlert(title: String, message: String) {
        let okAction = UIAlertAction(title: "Verstanden", style: .cancel, handler: nil)
        self.showAlert(title: title, message: message, actions: [okAction])
    }
}

