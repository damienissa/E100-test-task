//
//  GLService.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import GLMap

internal struct GLService {
    
    private static let key = "MAP_API_KEY"
    
    private init() { }
    
    static func configure() {
        
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: key) as? String {
            GLMapManager.shared.apiKey = apiKey
        }
    }
}
