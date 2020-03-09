//
//  BaseRouter.swift
//  GamerCollection
//
//  Created by Sergio Aragonés on 08/03/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class BaseRouter {
    
    func push(viewController: UIViewController, animated: Bool = true) {
        UIViewController.getCurrentNavigationController()?.pushViewController(viewController, animated: animated)
    }
}
