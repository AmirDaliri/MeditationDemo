//
//  ControllerKeys.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import UIKit

typealias ControllerKey = String

let kControllerMap: [ ControllerKey: (classType: UIViewController.Type, title: String)] =
    [
        ControllerKeys.main.rawValue: (MainVC.self, ""),
        ControllerKeys.detail.rawValue: (DetailVC.self, "")
    ]

enum ControllerKeys: ControllerKey {
    case main
    case detail
}

var kControllerTree: [ControllerKey: (index: Int, iconName: String)] = [:]
var kControllerTreeKeys: [ControllerKey] {
    return kControllerTree.keys.sorted { kControllerTree[$0]!.index < kControllerTree[$1]!.index }
}
var kControllerTreeCenterItem: ControllerKey {
    return kControllerTree.filter({$0.value.index == 1}).first!.0
}
