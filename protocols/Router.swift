//
//  Router.swift
//  HowManyYonda
//
//  Created by 最上聖也 on 2018/06/02.
//  Copyright © 2018年 SeiyaMogami. All rights reserved.
//

import Foundation
import UIKit

enum ViewTransitionStyle {
    case push, show
}

class Router {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func transition(to: UIViewController, style: ViewTransitionStyle, animationStyle: UIModalTransitionStyle = .coverVertical, animated: Bool = true) {
        switch style {
        case .push:
            guard let nav = viewController?.navigationController else {
                return
            }
            
            DispatchQueue.main.async {
                nav.pushViewController(to, animated: animated)
            }
        case .show:
            viewController?.modalTransitionStyle = animationStyle
            DispatchQueue.main.async {
                self.viewController?.present(to, animated: animated, completion: nil)
            }
        }
    }
    
    func close() {
        DispatchQueue.main.async {
            if let nav = self.viewController?.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.viewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func closeNavController() {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: true, completion: nil)
        }
    }
}
