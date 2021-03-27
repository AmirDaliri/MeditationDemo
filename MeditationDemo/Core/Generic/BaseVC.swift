//
//  BaseVC.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class BaseVC: UIViewController {
            
    // MARK: Preferred Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Preferred View Controller Styles
    var isNavigationBarHidden: Bool = false {
        didSet {
            if !isNavigationBarHidden {
                navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.6)
                navigationController?.navigationBar.tintColor = .white
                navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                navigationController?.navigationBar.isHidden = false
            } else {
                navigationController?.navigationBar.isHidden = true
            }
        }
    }
    
    var isNavigationBarTransparent: Bool = false {
        didSet {
            configureNavigationBarTransparently()
        }
    }
    
    var pageTitle: String? {
        didSet {
            self.title = self.pageTitle
        }
    }
    
    // MARK: Base Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
        
    func configureUI() {
        view.clipsToBounds = true
        configureNavigationBar()
    }
    
    deinit {
        self.data = nil
    }
    
    // MARK: - Configure NavigationBar
    func configureNavigationBar() {
        if !isNavigationBarHidden {
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.navigationBar.tintColor = .red
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.isHidden = false
        } else {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    func configureNavigationBarTransparently() {
        if self.isNavigationBarTransparent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.6)
            navigationController?.navigationBar.isOpaque = false
            navigationController?.navigationBar.isTranslucent = false
        }
    }

    
    //MARK: - this function configured for use in bindUI error case.
    public func handleAlertView(title: String?, message: String) {
        if let alertTitle = title {
            AlertBuilder().title(alertTitle).message(message)
                .addCancelAction(title: "OK")
            .show(in: self)
        } else {
            AlertBuilder().message(message)
                .addCancelAction(title: "OK")
            .show(in: self)
        }
    }
    
    
    // MARK: - Reachability Method
    @objc func statusManager(_ notification: Notification) {
        switch Network.reachability.status {
        case .unreachable:
            AlertBuilder().message("No internet connection. Please try again later.")
                .addCancelAction(title: "OK")
            .show(in: self)
        case .wwan,.wifi:
            if let topVC = NavigationManager.shared.topViewController(),
               topVC.isKind(of: UIAlertController.self) {
                NavigationManager.shared.closeTopController(true, data: false)
            }
        }
    }
}
