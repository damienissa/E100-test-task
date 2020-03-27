//
//  ViewController.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import UIKit
import GLMap

public class MapViewController: UIViewController {

    // MARK: - Properties
    
    internal var presenter: MapViewPresenterInput!
    
    internal lazy var mapView: MapView = {
        
        let mapView = MapView(frame: view.bounds, navigation: presenter.navigator)
        view.addSubview(mapView)
        
        return mapView
    }()
    
    
    // MARK: - Lifecycle
    
    internal init(_ presenter: MapViewPresenterInput) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - IBActions
    
    @objc
    private func removeLastPoint() {
        
        presenter?.removeLastPoint()
    }
    
    
    // MARK: - Actions
    
    private func setup() {
        
        presenter.set(navigationDelegate: mapView)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(removeLastPoint))
        navigationItem.leftBarButtonItem?.isEnabled = false
        title = "Map".localized
    }
}


// MARK: - MapViewPresenterOutput

extension MapViewController: MapViewPresenterOutput {
    
    public func set(removeButton enabled: Bool) {
        
        navigationItem.leftBarButtonItem?.isEnabled = enabled
    }
}
