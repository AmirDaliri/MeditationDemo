//
//  BaseVM.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

class BaseVM {
    private(set) var state = Observable(State.unknown)

    func setState(_ state: State) {
        self.state.value = state
    }
    
    func handlePopup(error: String?) {
        if let err = error {
            self.setState(.error(err))
        } else {
            self.setState(.error(nil))
        }
    }
}
