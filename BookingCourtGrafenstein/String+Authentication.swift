//
//  String+Authentication.swift
//  BookingCourtGrafenstein
//
//  Created by Thomas Krainz-Mischitz on 15.12.17.
//  Copyright © 2017 Thomas Krainz-Mischitz. All rights reserved.
//

import Foundation

extension String {
    
    func validEmailFormat() -> Bool {
        return true
    }
    
    func validPasswordLength() -> Bool {
        return self.count >= 8
    }
}
