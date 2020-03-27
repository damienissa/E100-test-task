//
//  Navigator.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import Foundation
import GLMap
import GLRoute

public final class Navigator {

    // MARK: - Properties
    
    private var storage: PointsStorage
    
    public weak var delegate: NavigationServiceDelegate?
    
    
    // MARK: - Lifecycle
    
    public init(storage: PointsStorage) {
    
        self.storage = storage
    }
}


// MARK: - NavigationService

extension Navigator: NavigationService {
    
    public func add(point: GLMapPoint) {
        
        storage.add(point)
    }
    
    public func removeLastPoint() {
        
        if let last = storage.getPoints().last {
            storage.remove(last)
        }
    }
    
    public func requestRoute() {
        
        let points = storage.getPoints()
        guard points.count >= 2 else { return }
        
        let routeRequest = GLRouteRequest()
        routeRequest.mode = GLRouteMode.drive
        
        points.forEach {
            routeRequest.add(GLRoutePoint(pt: GLMapGeoPoint(point: $0), heading: Double.nan, isStop: true))
        }
        
        Alert.showSpinner()
        routeRequest.start(completion: { [weak self] (result: GLRoute?, error: Error?) in
            Alert.hideSpinner()
            
            guard let self = self else { return }
            
            if let routeData = result {
                if let trackData = routeData.trackData(with: GLMapColor(red: 50, green: 200, blue: 0, alpha: 200)) {
                    self.delegate?.didReceive(trackData: trackData)
                }
            }
            
            if let error = error {
                self.removeLastPoint()
                self.delegate?.didReceive(error: error)
            }
        })
    }
}
