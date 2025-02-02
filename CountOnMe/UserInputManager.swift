import Foundation

class UserInputManager{
	
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
			return elements.last != "+" && elements.last != "-"
	}
	
	var expressionHaveResult: Bool {
		return elements.firstIndex(of: "=") != nil
	}
	
	func add(element: String) {
		if expressionHaveResult == false {
			elements.append(element)
		}else {
			elements.removeAll()
		}
	}
	
	func shoulAddOperand(_ operatorSymbol: String) -> Bool{
		if canAddOperator{
			elements.append(operatorSymbol.trimmingCharacters(in: .whitespaces))
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
				default: fatalError("Unknown operator !")
				}
				
				operationsToReduce = Array(operationsToReduce.dropFirst(3))
				operationsToReduce.insert("\(result)", at: 0)
		}
		elements.append(" = \(operationsToReduce.first!)")
	}
}
