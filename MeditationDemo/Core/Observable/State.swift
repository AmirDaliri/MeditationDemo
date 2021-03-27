//
//  State.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

enum State {
    case unknown, loading, success, error(String?)

    static func == (left: State, right: State) -> Bool {
        switch (left, right) {
        case (.unknown, .unknown):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
