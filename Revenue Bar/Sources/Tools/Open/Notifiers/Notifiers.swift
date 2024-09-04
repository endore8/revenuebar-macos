//
//  Notifiers.swift
//  Revenue Bar
//
//  Created by Oleh on 04/09/2024.
//

import Combine
import Foundation

typealias CurrentValueNotifier<T> = CurrentValueSubject<T, Never>
typealias TypeNotifier<T> = PassthroughSubject<T, Never>
typealias VoidNotifier = PassthroughSubject<Void, Never>

typealias NotifierContainer = AnyCancellable
typealias NotifiersContainer = Set<AnyCancellable>

extension CurrentValueNotifier where Output: Equatable {
    
    func send(ifChanged newValue: Output) {
        if self.value != newValue {
            self.send(newValue)
        }
    }
}

extension VoidNotifier {
    
    func send() {
        self.send(())
    }
}

extension NotifierContainer {
    
    func store(in value: inout NotifierContainer?) {
        value = self
    }
}
