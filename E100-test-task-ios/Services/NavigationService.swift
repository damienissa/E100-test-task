//
//  NavigationService.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import GLMap

public protocol NavigationServiceDelegate: class {
    
    func didReceive(trackData: GLMapTrackData)
    func didReceive(error: Error)
}

public protocol NavigationService {
    
    var delegate: NavigationServiceDelegate? { get set }
    
    func add(point: GLMapPoint)
    
    func removeLastPoint()
    func requestRoute()
}
