//
//  InMemoryStorage.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import GLMap

public let pointsStorageNotificationName: Notification.Name = .init("NavigatorDidChange")

public class InMemoryStorage  {
    
    // MARK: - Proerties
    
    private var points: [GLMapPoint] = [] {
        didSet {
            NotificationCenter.default.post(name: pointsStorageNotificationName, object: points)
        }
    }
}


// MARK: - PointsStorage

extension InMemoryStorage: PointsStorage {
    
    public func add(_ point: GLMapPoint) {
        
        points.append(point)
    }
    
    public func remove(_ point: GLMapPoint) {
        
        if let index = points.firstIndex(where: { point.x == $0.x && point.y == $0.y }) {
            points.remove(at: index)
        }
    }
    
    public func getPoints() -> [GLMapPoint] {
        
        points
    }
}

