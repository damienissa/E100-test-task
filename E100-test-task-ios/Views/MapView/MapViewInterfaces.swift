//
//  MapViewInterfaces.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

public protocol MapViewPresenterInput: class {
    
    var navigator: NavigationService { get }
    
    func removeLastPoint()
    func set(navigationDelegate delegate: NavigationServiceDelegate)
}

public protocol MapViewPresenterOutput: class {
    
    func set(removeButton enabled: Bool)
}
