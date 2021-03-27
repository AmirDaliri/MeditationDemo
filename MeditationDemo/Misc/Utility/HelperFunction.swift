//
//  HelperFunction.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

func delay(_ time: Double, _ completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        completion()
    }
}

var deviceHasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}
