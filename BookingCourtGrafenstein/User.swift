//
//  User.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 15.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import Foundation

class User: NSObject {
    
    let admin: Bool
    let firstname: String
    let lastname: String
    let id: String
    let payment: Bool
    let email: String
    
    public init(dictionary: [String: Any], uuid: String) {
        let admin = dictionary["admin"] as! Int
        let payment = dictionary["payment"] as! Int
        self.admin =  admin == 1
        self.payment = payment == 1
        self.id = uuid
        self.firstname = dictionary["firstname"] as! String
        self.lastname = dictionary["lastname"] as! String
        self.email = dictionary["email"] as! String
    }
    
    public init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as! String
        self.payment = dictionary["payment"] as! Bool
        self.admin = dictionary["admin"] as! Bool
        self.firstname = dictionary["firstname"] as! String
        self.lastname = dictionary["lastname"] as! String
        self.email = dictionary["email"] as! String
    }
    
    public func toDictionary() -> [String: Any] {
        return [
            "admin": self.admin,
            "payment": self.payment,
            "firstname": self.firstname,
            "lastname": self.lastname,
            "email": self.email,
            "uid": self.id
        ]
    }
}
