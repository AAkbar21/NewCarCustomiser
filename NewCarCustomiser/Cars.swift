//
//  Cars.swift
//  NewCarCustomiser
//
//  Created by Akbar, Abdullah (RCH) on 19/01/2023.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    func displayStats() -> String {
        return """
             Car Make: \(make)
             Car Model: \(model)
             Car topSpeed(125mph): \(topSpeed)
             Car acceleration(0-60): \(acceleration)s
             Car handling: \(handling)
             """
    }
}
