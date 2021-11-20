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
		return elements.last != "+" && elements.last != "-"
	}
	
	var expressionHaveEnoughElement: Bool {
			return elements.count >= 3
	}
	
	var canAddOperator: Bool {
		switch elements.last {
		case "+", "-", "x", "÷": return false
		default: return true
		}
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
	
	func shoulAddOperand(_ operatorSymbol: String) -> Bool{
		if canAddOperator{
			elements.append(operatorSymbol.trimmingCharacters(in: .whitespaces))
			if expressionHaveResult {
				let newArray = [elements[elements.count - 2], elements.last!]
				elements.removeAll()
				elements = newArray
			}
			return true
		}
		return false
	}
	
	func calculate(){
		// Create local copy of operations
		var operationsToReduce = elements
		
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
