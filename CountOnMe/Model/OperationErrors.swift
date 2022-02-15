//
//  OperationErrors.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 15/02/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Custom error type
enum OperationError: Error{
// error for the case where the user tries to include to many operands in an operation
  case NotAllowedToIncludOperand(String)
// error for the case where there is not enough elements when the user tapes "="
  case NotEnoughtElements(String)
// error for the case where the expression is not in the correct format.
  case NotCompleteOperation(String)
//  error for the case where the user tries to divide by zero.
  case zeroDivisionNotPossible
  case Unknown
  
  var description: String{
    switch self{
    case .NotEnoughtElements(let message):
      return message
    case .NotCompleteOperation(let message):
      return message
    case .NotAllowedToIncludOperand(let message):
      return message
    case .zeroDivisionNotPossible:
      return "Sorry its not possible to divide by zero!!"
    default: return "An unknown error did occured!!"
    }
  }
}
