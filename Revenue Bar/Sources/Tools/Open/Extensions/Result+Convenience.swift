//
//  Result+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 04/09/2024.
//

import Foundation

extension Result where Failure == Error {
    
    var error: Error? {
        switch self {
        case .success: nil
        case .failure(let error): error
        }
    }
}
