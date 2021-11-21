//
//  OperationManager.swift
//  CountOnMe
//
//  Created by Awaleh Moussa Hassan on 19/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class OperationManager{
	
	var elements =  [String](){
		didSet{ NotificationCenter.default.post(name: .dataDidChange, object: nil) }
	}
	
	// Error check computed variables
	var expressionIsCorrect: Bool {
		Operand.isOperand(elements.last ?? "") == false
	}
	
	var expressionHaveEnoughElement: Bool {
			return elements.count >= 3
	}
	
	var canAddOperator: Bool {
		Operand.isOperand(elements.last ?? "") == false
	}
	
	var expressionHaveResult: Bool {
		return elements.firstIndex(of: "=") != nil
	}
	
	func add(element: String) {
		if expressionHaveResult == false {
			if canAddOperator && elements.isEmpty == false {
				let lastElement = elements.removeLast()
				let newElement = lastElement + element
				elements.insert(newElement, at: elements.count)
			}else{
				elements.append(element)
			}
		}else {
			elements.removeAll()
		}
	}
	
	func shoulAddOperand(_ operatorSymbol: String) throws {
		guard canAddOperator else {
			throw OperationError.NotAllowedToIncludOperand("Un operateur est déja mis !")
		}
		elements.append(operatorSymbol.trimmingCharacters(in : .whitespaces))
		if expressionHaveResult {
			let newArray = [elements[elements.count - 2], elements.last!]
			elements.removeAll()
			elements     = newArray
		}
	}
	
	func calculate() throws {
		// Create local copy of operations
		var operationsToReduce = elements
		
		if expressionHaveEnoughElement == false {
			throw OperationError.NotEnoughtElements("Démarrez un nouveau calcul !")
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
				case "x": result = left * right
				case "÷": result = left / right
				default: fatalError("Unknown operator !")
				}
				
				operationsToReduce = Array(operationsToReduce.dropFirst(3))
				operationsToReduce.insert("\(result)", at: 0)
		}
		operationsToReduce.insert("=", at: 0)
		elements += operationsToReduce
	}
}

extension Notification.Name{
	static let dataDidChange = Notification.Name("DatadidChange")
}


enum OperationError: Error{
	case NotAllowedToIncludOperand(String)
	case NotEnoughtElements(String)
	case NotCompleteOperation(String)
	case Unknown
}

enum Operand: String {
	case addition = "+"
	case substraction = "-"
	case multiplication = "x"
	case division = "÷"
	
	static func isOperand(_ expression: String) -> Bool {
		switch expression {
		case "+", "-", "x", "÷": return true
		default: return false
		}
	}
}
