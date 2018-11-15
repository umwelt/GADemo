//
//  String.swift
//  GADemo
//
//  Created by BMGH SRL on 15/11/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation


/// https://stackoverflow.com/a/52120827/1091592


public extension String {
    
    /// Hashing algorithm for hashing a string instance.
    ///
    /// - Parameters:
    ///   - type: The type of hash to use.
    ///   - output: The type of output desired, defaults to .hex.
    /// - Returns: The requested hash output or nil if failure.
    public func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {
        
        // convert string to utf8 encoded data
        guard let message = data(using: .utf8) else { return nil }
        return message.hashed(type, output: output)
    }
}
