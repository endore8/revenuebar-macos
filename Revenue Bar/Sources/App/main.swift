//
//  main.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation
import Cocoa

let delegate = AppDelegate()
let menu = AppMenu()

let application = NSApplication.shared
application.delegate = delegate
application.menu = menu

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
