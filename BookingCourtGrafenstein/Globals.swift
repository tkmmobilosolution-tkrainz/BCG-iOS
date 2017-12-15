//
//  Globals.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 15.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import Foundation

public class Globals {
    
    static func setUser(user: User) {
        let defaults = UserDefaults.standard
        defaults.set(user.toDictionary(), forKey: "currentUser")
    }
    
    static func getUser() -> User {
        let defaults = UserDefaults.standard
        let user = User(dictionary: defaults.value(forKey: "currentUser") as! [String: Any])
        return user
    }
}
