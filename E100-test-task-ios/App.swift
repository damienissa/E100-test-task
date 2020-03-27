//
//  App.swift
//  E100-test-task-ios
//
//  Created by Dima Virych on 26.03.2020.
//  Copyright © 2020 Virych. All rights reserved.
//

import UIKit

struct App {
    
    static func configure(_ window: UIWindow?) {
        
        GLService.configure()
        window?.rootViewController = getVC()
        window?.makeKeyAndVisible()
    }
    
    private static func getVC() -> UIViewController {
        
        let composer = MapViewComposer()
        
        return UINavigationController(rootViewController: composer.viewController)
    }
}
