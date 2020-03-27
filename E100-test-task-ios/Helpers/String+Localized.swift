//
//  String+Localized.swift
//  Backflow
//
//  Created by Dmytro Virych on 9/7/16.
//  Copyright © 2016 Virych. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
