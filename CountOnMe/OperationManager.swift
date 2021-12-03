//
//  OperationManager.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 19/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class OperationManager{
	
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
		Operand.isOperand(expression.last ?? "") == false
	}
//	Checks if the expression has an "=" sign
	var expressionHaveResult: Bool {
		return expression.firstIndex(of: "=") != nil
	}
	
//	Adding an element to the expression
	func add(element: String) {
		if expressionHaveResult == false {
			if canAddOperator && expression.isEmpty == false {
//				adding element in the case where the last element is an element.
				let lastElement = expression.removeLast()
				let newElement = lastElement + element
				expression.insert(newElement, at: expression.count)
			}else{
//				in the case where the last element is  an operand
				expression.append(element)
			}
		}else {
//			Emty the expresion to start from scratch.
			expression.removeAll()
//			adds the element to the expression
			expression.append(element)
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
		expression.append(operatorSymbol.trimmingCharacters(in : .whitespaces))
		if expressionHaveResult {
//			Cleans and get rids of the previous operation
			let newArray = [expression[expression.count - 2], expression.last!]
			expression.removeAll()
			expression     = newArray
		}
	}
	
	func calculate() throws {
		// Create local copy of operations
		var operationsToReduce = expression
//		Checks if there is enough elements
		if expressionHaveEnoughElement == false {
			throw OperationError.NotEnoughtElements("Démarrez un nouveau calcul !")
//			Make a last check
		}else if expressionIsCorrect == false || expressionHaveResult == true {
			throw OperationError.NotCompleteOperation("Entrez une expression correcte !")
		}
		
		// Iterate over operations while an operand still here
		while operationsToReduce.count > 1 {
				let left = Int(operationsToReduce[0])!
				let operand = operationsToReduce[1]
				let right = Int(operationsToReduce[2])!
				
				let result: Int
				switch operand {
				case "+": result = left + right
				case "-": result = left - right
//					Added operand symbols for multiplication and division
				case "x": result = left * right
				case "÷": result = left / right
				default: fatalError("Unknown operator !")
				}
				
				operationsToReduce = Array(operationsToReduce.dropFirst(3))
				operationsToReduce.insert("\(result)", at: 0)
		}
		operationsToReduce.insert("=", at: 0)
		expression += operationsToReduce
	}
}

//Extended the Notification.Name type with a custome one.
extension Notification.Name{
	static let dataDidChange = Notification.Name("DatadidChange")
}

// Custom error type
enum OperationError: Error{
// error for the case where the user tries to include to many operands in an operation
	case NotAllowedToIncludOperand(String)
// error for the case where there is not enough elements when the user tapes "="
	case NotEnoughtElements(String)
// error for the case where the expression is not in the correct format.
	case NotCompleteOperation(String)
	case Unknown
}
// Custom type for the different types
enum Operand: String {
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
}
