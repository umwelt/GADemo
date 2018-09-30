//
//  Dates.swift
//  GADemo
//
//  Created by BMGH SRL on 30/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation

public struct Dates: Codable {
    public let maximum: String?
    public let minimum: String?
    
    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }
    
    public init(maximum: String?, minimum: String?) {
        self.maximum = maximum
        self.minimum = minimum
    }
}
