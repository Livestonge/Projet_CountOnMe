//
//  OperationManager.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 19/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class OperationManager{
  
	// a variable for when to start a new operation
  var startNewOperation = true
// An array for the data entered by the user.
	var expression =  [String](){
//		Post a notification every time there is a change.
		didSet{ NotificationCenter.default.post(name: .dataDidChange, object: nil) }
	}
	
	// Error check computed variables
	var expressionIsCorrect: Bool {
		Operand.isOperand(expression.last ?? "") == false
	}
//	An operation should have at least 3 elements when "=" is tapped.
	var expressionHaveEnoughElement: Bool {
			return expression.count >= 3
	}
//	The user can add an operand if the last element of the expression is not an operand
	var canAddOperator: Bool {
    return Operand.isOperand(expression.last ?? "") == false
	}
	
//	Adding an element to the expression
	func add(element: String) {
			if canAddOperator && expression.isEmpty == false {
//		adding element in the case where the last element is an element.
				let lastElement = expression.removeLast()
        let newElement = !startNewOperation ? lastElement + element : element
				expression.insert(newElement, at: expression.count)
			}else{
//				in the case where the last element is  an operand
        if startNewOperation == false {
          expression.append(element)
        }else{
          expression.removeAll()
          expression = [element]
        }
			}
	}
	
// Method for adding operand
	func shoulAddOperand(_ operatorSymbol: String) throws {
//		Checks if an operand should be added.
		guard canAddOperator else {
//			Throws an error
			throw OperationError.NotAllowedToIncludOperand("Un operateur est déja mis !")
		}
//		Get rids of white space before adding.
    startNewOperation = false
    if expression.count >= 3 { try? calculate() }
		expression.append(operatorSymbol.trimmingCharacters(in : .whitespaces))
	}
  
  func showEndResult() throws {
    try calculate()
    startNewOperation = true
  }
	
	private func calculate() throws {
//		Checks if there is enough elements
		if expressionHaveEnoughElement == false {
			throw OperationError.NotEnoughtElements("Démarrez un nouveau calcul !")
//	Make a last check
		}else if expressionIsCorrect == false {
			throw OperationError.NotCompleteOperation("Entrez une expression correcte !")
		}
    // Create local copy of operations
    var calculator = Calculator(operationsToReduce: expression)
    expression = try calculator.getResult()
	}
  
  func reset(){
    expression.removeAll()
    startNewOperation = true
  }
}





