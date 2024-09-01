//
//  VoidClosure.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation

typealias TypeClosure<T> = (T) -> Void
typealias TypeResultClosure<T> = (Result<T, Error>) -> Void
typealias VoidClosure = () -> Void
