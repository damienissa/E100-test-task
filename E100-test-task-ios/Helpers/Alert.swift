//
//  Alert.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import UIKit

fileprivate class Spinner: UIViewController {
    
    // MARK: - Singleton
    
    static var shared: Spinner = {
        
        let vc = Spinner()
        _ = vc.view
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        return vc
    }()
    
    
    // MARK: - Properties
    
    private lazy var spin: UIActivityIndicatorView = {
        
        let spin = UIActivityIndicatorView(style: .large)
        spin.hidesWhenStopped = true
        spin.startAnimating()
        view.addSubview(spin)
        
        return spin
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spin.center = view.flatMap { CGPoint(x: $0.frame.width / 2, y: $0.frame.height / 2) }!
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
}


// MARK: - Alert

struct Alert {
    
    // MARK: - Properties
    
    private static var topViewController: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
    
    
    // MARK: - Activity indicator
    
    static func showSpinner() {
        
        topViewController?.present(Spinner.shared, animated: false, completion: nil)
    }
    
    static func hideSpinner() {
        
        Spinner.shared.dismiss(animated: false, completion: nil)
    }
    
    
    // MARK: - Alert
    
    static func show(_ error: Error, completion: (() -> Void)? = nil) {
        
        present(error.localizedDescription)
    }
    
    static func show(_ message: String, completion: (() -> Void)? = nil) {
        
        present(message)
    }
    
    
    // MARK: - Private Actions
    
    private static func present(_ message: String, completion: (() -> Void)? = nil) {
        
        let controller = UIAlertController(title: "Error".localized, message: message, preferredStyle: .alert)
        controller.addAction(.init(title: "OK".localized, style: .cancel, handler: nil))
        topViewController?.present(controller, animated: true, completion: completion)
    }
}
