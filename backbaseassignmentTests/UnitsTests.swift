//
//  UnitsTests.swift
//  backbaseassignmentTests
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import XCTest

class UnitsTests: XCTestCase {
    
    var metric: Units?
    var imperial: Units?
    var empty: Units?

    override func setUp() {
        
        metric = Units(rawValue: "metric")
        imperial = Units(rawValue: "imperial")
        empty = Units(rawValue: "wrongvalue")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMetric() {
        
        XCTAssertNotNil(metric)
        assert(metric == .metric)
    }
    
    func testImperial() {
        
        XCTAssertNotNil(imperial)
        assert(imperial == .imperial)
    }
    
    func testEmpty() {
        
        XCTAssertNil(empty)
    }

}
