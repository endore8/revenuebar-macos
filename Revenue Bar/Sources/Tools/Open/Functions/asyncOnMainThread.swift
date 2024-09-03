//
//  asyncOnMainThread.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import Foundation

/// Executes closure on the main thread.
func asyncOnMainThread(_ closure: @escaping VoidClosure) {
    DispatchQueue.main.async(execute: closure)
}

/// Executes closure on the main thread with 0.1 second delay.
func asyncOnMainThreadDelayed(_ closure: @escaping VoidClosure) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: closure)
}

/// Executes closure on the main thread with given delay.
func asyncOnMainThreadDelayed(delay: TimeInterval, _ closure: @escaping VoidClosure) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
