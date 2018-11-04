//
//  WeatherSystemTests.swift
//  backbaseassignmentTests
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import XCTest

class WeatherSystemTests: XCTestCase {

    let jsonFile = "weathersystem"
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
        let data = WeatherSystem(json: json!)
        
        XCTAssertNotNil(data.id)
        assert(data.id == 5214)
        
        XCTAssertNotNil(data.sunrise)
        assert(data.sunrise?.timeIntervalSince1970 == 1541227353)
        
        XCTAssertNotNil(data.sunset)
        assert(data.sunset?.timeIntervalSince1970 == 1541261363)
        
        XCTAssertNotNil(data.countryCode)
        assert(data.countryCode == "NL")
    }

}
