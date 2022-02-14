//
//  Calculator.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 14/02/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation


struct Calculator {
  
  var operationsToReduce: [String]
  var startsWithOperand = false
  
  mutating func getResult() throws -> [String] {
    
    self.startsWithOperand = Operand.isOperand(operationsToReduce.first ?? "")
    while operationsToReduce.count > 2 {
      let left =  startsWithOperand ?  Int(operationsToReduce[0...1].joined(separator: ""))!: Int(operationsToReduce[0])!
      let operand = startsWithOperand ? operationsToReduce[2] : operationsToReduce[1]
      let right = startsWithOperand ? Int(operationsToReduce[3])!: Int(operationsToReduce[2])!
          // Iterate over operations while an operand still here
      
      startsWithOperand = false
        let result: Int
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
//      Added operand symbols for multiplication and division
        case "x": result = left * right
        case "÷" where right != 0 : result = left / right
        case "÷" where right == 0 : throw OperationError.zeroDivisionNotPossible
        default: fatalError("Unknown operator !")
        }
//      After each operation of type A operand B, I drop those elements of the expression
        
      operationsToReduce = ["\(result)"]
    }
    return operationsToReduce
  }
}
