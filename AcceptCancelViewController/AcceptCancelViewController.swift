//
//  AcceptCancelViewController.swift
//  AcceptCancelViewController
//
//  Created by Cao Phuoc Thanh on 10/28/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

// MARK: Controller
class AcceptCancelViewController: UIViewController {
    
    private let maxSizeWith: CGFloat = (UIScreen.main.bounds.width > 420) ? 420 : (UIScreen.main.bounds.width - 16)
    
    private var leftButtonDidTouchHandler: (() -> ())? = nil
    private var rightButtonDidTouchHandler: (() -> ())? = nil
    private var _title: String?
    private var _message: String?
    
    
    required convenience init(title: String? = nil,
                              message: String,
                              leftButtonTitle: String,
                              rightButtonTitle: String,
                              leftButtonDidTouch: @escaping (() -> ()),
                              rightButtonDidTouch: @escaping (() -> ())) {
        self.init()
        self._title = title
        self._message = message
        self._view.titleLabel.text = _title
        self._view.messageLabel.text = _message
        self._view.leftButton.setTitle(leftButtonTitle, for: .normal)
        self._view.rightButton.setTitle(rightButtonTitle, for: .normal)
        self.leftButtonDidTouchHandler = leftButtonDidTouch
        self.rightButtonDidTouchHandler = rightButtonDidTouch
    }
    
    private var _view: AlertView = {
        return AlertView()
    }()
    
    override func loadView() {
        super.loadView()
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
        
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view = _view
            let height = self.conculateContentHeight(text: _title, font: self._view.titleLabel.font) + self.conculateContentHeight(text: _message, font: self._view.messageLabel.font)
            self.navigationController?.preferredContentSize = CGSize(
                width: maxSizeWith,
                height: height + 24 + 44
            )
        } else {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            self.view.addSubview(_view)
            self._view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:[v(w)]",
                options: [], metrics: ["w": 320], views: ["v": _view]))
            self.view.addConstraint(NSLayoutConstraint.init(item: _view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint.init(item: _view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
            self._view.layer.cornerRadius = 8
            self._view.layer.masksToBounds = true
        }
        self._view.titleLabel.text = _title
        self._view.messageLabel.text = _message
        
        self._view.leftButton.addTarget(self, action: #selector(self.leftButtonDidTouch), for: .touchUpInside)
        self._view.rightButton.addTarget(self, action: #selector(self.rightButtonDidTouch), for: .touchUpInside)
        
    }
    
    @objc dynamic private func leftButtonDidTouch() {
        self.navigationController?.dismiss(animated: true, completion: {
            self.leftButtonDidTouchHandler?()
        })
    }
    
    @objc dynamic private func rightButtonDidTouch() {
        self.navigationController?.dismiss(animated: true, completion: {
            self.rightButtonDidTouchHandler?()
        })
    }
    
    private func conculateContentHeight(text: String?, font: UIFont) -> CGFloat {
        guard let text = text else { return 0 }
        let maxSize: CGSize = CGSize(width: maxSizeWith, height: UIScreen.main.bounds.height)
        let nsText = text as NSString?
        return nsText?.boundingRect(with: maxSize, options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil).size.height ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: View
extension AcceptCancelViewController {
    
    class AlertView: UIView {
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        
        lazy var messageLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = UIColor.black.withAlphaComponent(0.7)
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        lazy var leftButton: UIButton = {
            let button = UIButton()
            button.setTitle("Cancel", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.lightGray
            button.layer.cornerRadius = 4
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            return button
        }()
        
        lazy var rightButton: UIButton = {
            let button = UIButton()
            button.setTitle("OK", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.orange
            button.layer.cornerRadius = 4
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.layer.masksToBounds = true
            return button
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupUI()
            self.setupConstraints()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.addSubview(titleLabel)
            self.addSubview(messageLabel)
            self.addSubview(leftButton)
            self.addSubview(rightButton)
            
            self.backgroundColor = UIColor.white
            
        }
        
        private func setupConstraints() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            leftButton.translatesAutoresizingMaskIntoConstraints = false
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[v]-|",
                options: [],
                metrics: nil,
                views: ["v": titleLabel]))
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[v]-|",
                options: [],
                metrics: nil,
                views: ["v": messageLabel]))
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-16-[v1]-16-[v2]-16-|",
                options: [], metrics: nil,
                views: ["v1": leftButton, "v2": rightButton]))
            self.addConstraint(NSLayoutConstraint(
                item: leftButton,
                attribute: .width,
                relatedBy: .equal,
                toItem: rightButton,
                attribute: .width,
                multiplier: 1.0,
                constant: 0))
            
            let topSpace: CGFloat = 0
            let bottomSpace: CGFloat = 0
            
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(top)-[v1(44)]-16-[v2(>=0)]-24-[v3(40)]-(bottom)-|",
                options: [],
                metrics: ["top":topSpace + 8, "bottom":bottomSpace + 16],
                views: ["v1": titleLabel,  "v2": messageLabel, "v3": leftButton]))
            
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:[v2]-24-[v3(40)]-(bottom)-|",
                options: [],
                metrics: ["bottom": bottomSpace + 16],
                views: ["v2": messageLabel, "v3": rightButton]))
        }
        
    }
}

extension UIApplication {

    /// The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }

}
