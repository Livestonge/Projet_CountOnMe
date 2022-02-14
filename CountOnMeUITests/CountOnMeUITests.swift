//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Awaleh Moussa Hassan on 21/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//
import Foundation
import XCTest
@testable import CountOnMe

class CountOnMeUITests: XCTestCase {
	
	  var app: XCUIApplication!
	  var textViewElement: XCUIElement!
	
	  var randomOperand: String{
			let buttonCollection = ["+", "-", "x", "÷"]
			let randomIndex = Int.random(in: 0..<buttonCollection.count)
			return buttonCollection[randomIndex]
	  }
	
    override func setUpWithError() throws {
			try super.setUpWithError()
			continueAfterFailure = false
			app = XCUIApplication()
			app.launch()
			textViewElement = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
    }
	
	func testNumberButtons(){
		
		//given
		let randomNumberDescription = Int.random(in: 0..<9).description
		
		//when
		app.buttons[randomNumberDescription].tap()
		
		//then
		let expressionOnTextView = textViewElement.value as? String
		XCTAssertEqual(expressionOnTextView, randomNumberDescription)
		
	}
	
	func testMultiDigitNumberCase(){
		
		//given
		var randomNumberDescription = ""
		for _ in [0..<3] {
			//when
			let digitDescription = Int.random(in: 0..<9).description
			randomNumberDescription += digitDescription
			app.buttons[randomNumberDescription].tap()
		}
		//then
		let expressionOnTextView = textViewElement.value as? String
		XCTAssertEqual(expressionOnTextView, randomNumberDescription)
	}
	
	func testOperandButtons(){
		//given
		let randomOperand = randomOperand
		//when
		app.buttons[randomOperand].tap()
		//then
		let expressionOnTextView = textViewElement.value as? String
		XCTAssertEqual(expressionOnTextView, randomOperand)
	}
	
	func createRandomOperation() -> String {
		//given
		var randomOperationDescription = ""
		let operand = randomOperand
		let randomNumberDescription = Int.random(in: 0..<9).description
		
		//when
		app.buttons[randomNumberDescription].tap()
		randomOperationDescription += randomNumberDescription
		app.buttons[operand].tap()
		randomOperationDescription += operand
		app.buttons[randomNumberDescription].tap()
		randomOperationDescription += randomNumberDescription
		return randomOperationDescription
	}
	
	func testOperation(){
		//when
		let expression = createRandomOperation()
		//then
		XCTAssertEqual(textViewElement.value as? String, expression)
	}
  
  func testZeroDivision(){
    
//    When
    app.buttons["6"].tap()
    app.buttons["÷"].tap()
    app.buttons["0"].tap()
    app.buttons["="].tap()
    
    //then
    XCTAssertTrue(app.alerts["Zéro!"].scrollViews.otherElements.staticTexts["Sorry its not possible to divide by zero!!"].exists)
  }
	
  	func testMultiOperandOperation(){
		//when
    app.buttons["4"].tap()
		app.buttons["x"].tap()
    app.buttons["3"].tap()
    let newOperand = randomOperand
      app.buttons[newOperand].tap()
		let expression = ["12\(newOperand)"]
		//then
    XCTAssertEqual(textViewElement.value as? String, expression.joined(separator: ""))
	}
	
	func testOperandsMisuse(){
		//given
		let operand_1 = randomOperand
		let operand_2 = randomOperand
    //when
		app.buttons[operand_1].tap()
		app.buttons[operand_2].tap()
		
		//then
		XCTAssertTrue(app.alerts["Zéro!"].scrollViews.otherElements.staticTexts["Un operateur est déja mis !"].exists)
		
	}
	
	func testWrongOperationSetup(){
		//when
		app.buttons[Int.random(in: 0...9).description].tap()
		app.buttons["\(randomOperand)"].tap()
		app.buttons["="].tap()
		//then
		XCTAssertTrue(app.alerts["Zéro!"].scrollViews.otherElements.staticTexts["Démarrez un nouveau calcul !"].exists)
	}
	
	
	
}
