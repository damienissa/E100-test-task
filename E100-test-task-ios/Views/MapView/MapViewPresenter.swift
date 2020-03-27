//
//  MapViewPresenter.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import Foundation

internal class MapViewPresenter {
    
    internal weak var output: MapViewPresenterOutput?
    internal var navigator: NavigationService
    
    private let storage: PointsStorage
    
    internal init(_ navigator: NavigationService, storage: PointsStorage) {
        
        self.storage = storage
        self.navigator = navigator
        
        addObserver()
    }
    
    
    // MARK: - Actions
    
    private func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView(_:)), name: pointsStorageNotificationName, object: nil)
    }
    
    @objc
    private func updateView(_ notification: Notification) {
        
        guard let count = (notification.object as? Array<Any>)?.count else { return }
        
        output?.set(removeButton: count > 2)
    }
}


// MARK: - MapViewPresenterInput

extension MapViewPresenter: MapViewPresenterInput {
    
    func removeLastPoint() {
        
        navigator.removeLastPoint()
        navigator.requestRoute()
    }
    
    func set(navigationDelegate delegate: NavigationServiceDelegate) {
        
        navigator.delegate = delegate
    }
}
