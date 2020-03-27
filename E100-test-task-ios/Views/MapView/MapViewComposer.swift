//
//  MapViewComposer.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import UIKit

public final class MapViewComposer {
    
    // MARK: - Properties
    
    private var navigator: NavigationService!
    private var storage: PointsStorage!
    
    public var viewController: MapViewController!
    
    
    // MARK: - Lifecycle
    
    public init() {

        storage = InMemoryStorage()
        navigator = Navigator(storage: storage)
        
        let presenter = MapViewPresenter(navigator, storage: storage)
        
        viewController = MapViewController(presenter)

        presenter.output = viewController
    }
}
