//
//  Operand.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 14/02/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Custom type for the different types
enum Operand: String, CaseIterable {
  case addition = "+"
  case substraction = "-"
  case multiplication = "x"
  case division = "÷"
// static method for checking if an string correspond to an operand or not.
  static func isOperand(_ text: String) -> Bool {
    switch text {
    case "+", "-", "x", "÷": return true
    default: return false
    }
  }
  
  static var operands: [String]{
    return Operand.allCases.map(\.rawValue)
  }
}
