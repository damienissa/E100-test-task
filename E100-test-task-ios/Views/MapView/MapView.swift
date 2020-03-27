//
//  MapView.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import GLMap
import GLRoute

internal class MapView: UIView {
    
    // MARK: - Properties
    
    private let navigation: NavigationService
    
    private var map: GLMapView!
    private var routeTrack: GLMapTrack?
    private var pins: [GLMapMarkerLayer] = []
    
 
    // MARK: - Lifecycle
    
    internal init(frame: CGRect, navigation: NavigationService) {
        
        self.navigation = navigation
        
        super.init(frame: frame)

        loadMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Please use init(frame: CGRect) for init")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        map?.frame = bounds
    }
    
    
    // MARK: - Private Actions
    
    private func addMap() {
        
        map = GLMapView(frame: frame)
        map.showUserLocation = true
        
        addSubview(map)
    }
    
    private func requestRouteTrack() {
        
        navigation.requestRoute()
    }
    
    private func loadMap() {
        
        addMap()
        map.longPressGestureBlock = { [weak self] point in
            
            self?.longPressHandler(point)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(pointsStorageDidChange(_:)), name: pointsStorageNotificationName, object: nil)
    }
    
    private func longPressHandler(_ point: CGPoint) {
        
        let point = map.makeMapPoint(fromDisplay: point)
        makePin(point)
        navigation.add(point: point)
        requestRouteTrack()
    }
    
    private func makePin(_ point: GLMapPoint) {
        
        let styles = GLMapMarkerStyleCollection()
        styles.addStyle(with: GLMapVectorImageFactory.shared.image(fromSvgpb: Bundle.main.path(forResource: "cluster", ofType: "svgpb")!, withScale: 0.2, andTintColor: GLMapColor(red: 0xFF, green: 0, blue: 0, alpha: 0xFF))!)
        styles.setMarkerLocationBlock { (marker) -> GLMapPoint in
            if let obj = marker as? GLMapVectorObject {
                return obj.point
            }
            return GLMapPoint()
        }
    
        let layer = GLMapMarkerLayer(markers: [GLMapVectorObject(point: point)], andStyles: styles, clusteringRadius: 0, drawOrder: 2)
        map.add(layer)
        pins.append(layer)
    }
    
    @objc
    private func pointsStorageDidChange(_ notif: Notification) {
        
        pins.forEach { map.remove($0) }
        pins.removeAll()
        if let points = notif.object as? [GLMapPoint] {
            points.forEach { makePin($0) }
        }
    }
}


// MARK: - NavigationServiceDelegate

extension MapView: NavigationServiceDelegate {
    
    func didReceive(trackData: GLMapTrackData) {
        
        if let track = self.routeTrack {
            track.setTrackData(trackData)
        } else {
            let track = GLMapTrack(drawOrder: 5, andTrackData: trackData)
            track.setStyle(GLMapVectorStyle.createStyle("{width: 7pt; fill-image:\"track-arrow.svgpb\";}"))
            self.map.add(track)
            self.routeTrack = track
        }
    }
    
    func didReceive(error: Error) {
        
        Alert.show(error)
    }
}
