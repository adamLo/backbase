//
//  WeatherCloudsTests.swift
//  backbaseassignmentTests
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import XCTest

class WeatherCloudsTests: XCTestCase {

    let jsonFile = "weatherclouds"
    var json: [String: Any]?
    
    override func setUp() {
        
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: jsonFile, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch {
                assertionFailure("Failed to parse json")
            }
        }
        else {
            assertionFailure("Failed to parse json")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJsonLoaded() {
        assert(json != nil, "Json not loaded")
    }
    
    func testParsing() {
        
        XCTAssertNotNil(json)
        let data = WeatherClouds(json: json!)
        
        XCTAssertNotNil(data.all)
        assert(data.all == 8)        
    }

}
