//
//  PointsStorage.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import GLMap

public protocol PointsStorage {
    
    func add(_ point: GLMapPoint)
    func remove(_ point: GLMapPoint)
    func getPoints() -> [GLMapPoint]
}

