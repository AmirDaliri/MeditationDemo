//
//  ControllerFactory.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

class ControllerFactory {
    
    static func navigationController(_ root: UIViewController, popGestureEnabled: Bool = false) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.isOpaque = false
        navigationController.navigationBar.isTranslucent = false
        navigationController.interactivePopGestureRecognizer?.isEnabled = popGestureEnabled
        return navigationController
    }
    
    static func viewController(_ controllerKey: ControllerKey,
                               data: Any? = nil) -> UIViewController? {
        
        // Special Case
        if controllerKey == ControllerKeys.main.rawValue {
            return ControllerFactory.mainController(data)
        }
        
        if let nClass = kControllerMap[controllerKey]?.classType {
            let controller = nClass.init()
            controller.controllerKey = controllerKey
            if let safeData = data {
                controller.data = safeData
            }
            var hideTabBarControl: Bool = false
            for contKey in kControllerTreeKeys where contKey == controllerKey {
                hideTabBarControl = true
            }
            controller.hidesBottomBarWhenPushed = !hideTabBarControl
            
            return controller
        }
        
        return nil
    }
    
    static func mainController(_ data: Any? = nil) -> UITabBarController {
        var dataArray: [Any]?
        if let safeData = data {
            if let dArray = safeData as? [Any] {
                dataArray = dArray
            }
            dataArray = [safeData]
        }
        let tabController = ControllerFactory.tabBarController(kControllerTreeKeys,
                                                               datas: dataArray)
        return tabController
    }
}
