//
//  UserInterface.swift
//  HowManyYonda
//
//  Created by 最上聖也 on 2018/06/02.
//  Copyright © 2018年 SeiyaMogami. All rights reserved.
//

import UIKit

protocol UserInterface: class {
    func show(_ alert: UIAlertController)
    func setNavigationTitle(_ title: String)
}

extension UserInterface where Self: UIViewController {
    func show(_ alert: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func setNavigationTitle(_ title: String) {
        self.navigationItem.title = title
    }
}
