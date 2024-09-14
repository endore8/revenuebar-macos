//
//  String+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import Foundation

extension String {
    
    var asMarkdownAttributedString: AttributedString {
        (try? AttributedString(markdown: self, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace))) ?? AttributedString(self)
    }
    
    static let empty: String = ""
    
    static var uuidString: String {
        UUID().uuidString
    }
}
