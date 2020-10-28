//
//  UIViewControllerExtension.swift
//  AcceptCancelViewController
//
//  Created by Cao Phuoc Thanh on 10/28/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

// MARK: UIViewController - Extention
public extension UIViewController {
    
    func showAlert(title: String? = nil,
                   message: String,
                   leftButtonTitle: String,
                   rightButtonTitle: String,
                   leftButtonDidTouch: @escaping (() -> ()),
                   rightButtonDidTouch: @escaping (() -> ())) {
        
        let viewController = AcceptCancelViewController(
            title: title,
            message: message,
            leftButtonTitle: leftButtonTitle,
            rightButtonTitle: rightButtonTitle,
            leftButtonDidTouch: leftButtonDidTouch,
            rightButtonDidTouch: rightButtonDidTouch
        )
        
        let navController = UINavigationController(rootViewController: viewController)
        if UIDevice.current.userInterfaceIdiom == .pad {
            navController.modalPresentationStyle = .formSheet
        } else {
            navController.modalPresentationStyle = .custom
        }
        navController.modalTransitionStyle = .crossDissolve
        self.present(navController, animated: true, completion: nil)
    }
}
