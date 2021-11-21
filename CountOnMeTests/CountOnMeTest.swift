//
//  CountOnMeTest.swift
//  CountOnMeTests
//
//  Created by Awaleh Moussa Hassan on 21/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTest: XCTestCase {
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
	
	  func testCountOnMeAddition(){
		
			//given
			sut.elements = ["2", "+", "3"]
			
			// when
			try? sut.calculate()
			
			//then
			XCTAssertEqual(sut.elements.last, "5")
	  }

}
