//
//  ViewController.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import UIKit
import GLMap

class MapViewController: UIViewController {

    // MARK: - IBOutlets
    
    var mapView: MapView!
    
    
    // MARK: - Properties
    
    var navigator: NavigationService!
    var storage: InMemoryStorage!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage = InMemoryStorage()
        navigator = Navigator(storage: storage)
        mapView = MapView(frame: view.bounds, navigation: navigator)
        navigator.delegate = mapView
        view.addSubview(mapView)
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        addObserver()
        
        title = "Map".localized
    }
    
    
    // MARK: - IBActions
    
    @IBAction func removeLastPoint() {
        
        navigator.removeLastPoint()
        navigator.requestRoute()
    }
    
    
    // MARK: - Actions
    
    private func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView(_:)), name: pointsStorageNotificationName, object: nil)
    }
    
    @objc
    private func updateView(_ notification: Notification) {
        
        guard let count = (notification.object as? Array<Any>)?.count else { return }
        
        navigationItem.leftBarButtonItem?.isEnabled = count > 2
    }
}

