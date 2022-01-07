//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Awaleh Moussa Hassan on 21/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
class CountOnMeTests: XCTestCase {
	var sut: OperationManager!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
			try super.setUpWithError()
			sut = OperationManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
			  sut = nil
			  try super.tearDownWithError()
    }
	
	func testAdditions(){
		
		//given
		sut.expression = ["2", "+", "3"]
		
		//when
		try? sut.calculate()
		
		//then
		XCTAssertEqual(sut.expression.last, "5")
	}
	
	func testSubtraction(){
		
		//given
		sut.expression = ["2", "-", "3"]
		
		//when
		try? sut.calculate()
		
		//then
		XCTAssertEqual(sut.expression.last, "-1")
	}
	
	func testMultiplication(){
		
		//given
		sut.expression = ["2", "x", "3"]
		
		//when
		try? sut.calculate()
		
		//then
		XCTAssertEqual(sut.expression.last, "6")
	}
	
	func testDivision(){
		
		//given
		sut.expression = ["12", "÷", "3"]
		
		//when
		try? sut.calculate()
		
		//then
		XCTAssertEqual(sut.expression.last, "4")
	}
	
	func testEdgeCase_1(){
		
		// given
		sut.expression = ["2", "+"]
		
		// when
		try? sut.shoulAddOperand("-")
		
		//then
		XCTAssertEqual(sut.expression, ["2", "+"])
	}
	
	func testEdgeCase_2(){
		
		// given
		sut.expression = ["5"]
		
		// when
		try? sut.shoulAddOperand("+")
		
		//then
		XCTAssertEqual(sut.expression, ["5", "+"])
	}
	
	func testEdgeCase_3(){
		
		// given
		sut.expression = ["2", "x", "5", "÷", "2", "+", "4"]
		
		// when
		try? sut.calculate()
		
		//then
		XCTAssertEqual(sut.expression.last, "9")
	}

}
