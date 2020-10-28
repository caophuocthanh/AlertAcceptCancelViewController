//
//  ViewController.swift
//  Demo
//
//  Created by Cao Phuoc Thanh on 10/28/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit
import AcceptCancelViewController

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("TAP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(button)
        self.view.addConstraint(NSLayoutConstraint.init(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: button, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.button.addTarget(self, action: #selector(self.tap), for: .touchUpInside)
    }
    
    @objc func tap() {
        self.showAlert(title: "Opp!",
                       message: "Are you Okay? In this lesson, you’ll learn how to chair a meeting in English. You can learn business English words and phrases which you can use in your next meeting. Practice your business English phrases and conversation skills with an online English teacher.",
                       leftButtonTitle: "Not well",
                       rightButtonTitle: "I'm OK",
                       leftButtonDidTouch: {
                        print("leftButtonDidTouch")
        }) {
            print("rightButtonDidTouch")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

