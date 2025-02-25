//
//  Observable.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

public final class Observable<T> {
    
    public typealias Observer = (T) -> Void
    
    private var observers: [Int: Observer] = [:]
    private var uniqueID = (0...).makeIterator()
    
    public var value: T {
        didSet{
            observers.values.forEach { $0(value) }
        }
    }
    
    public init (_ value: T) {
        self.value = value
    }
    
    public func observe(_ observer: @escaping Observer) -> Disposable {
        guard let id = uniqueID.next() else { fatalError("There should always be a next uniqe id") }
        
        observers[id] = observer
        observer(value)
        
        let disposable = Disposable { [weak self] in
            self?.observers[id] = nil
        }
        
        return disposable
    }
    
    public func removeAllObservers() {
        observers.removeAll()
    }
}
