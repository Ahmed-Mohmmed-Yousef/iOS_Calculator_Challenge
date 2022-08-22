//
//  Operation.swift
//  iOS_Calculator_Challenge
//
//  Created by Ahmed on 22/08/2022.
//

import Foundation

enum OprationType: String, CaseIterable {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "*"
    case division = "/"
}

struct Operation {
    let index: Int
    let operand: Double
    let operationType: OprationType
}
