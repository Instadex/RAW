//
//  RAWUITests.swift
//  RAWUITests
//
//  Created by Bharat malhotra on 02/08/18.
//  Copyright © 2018 Bharat malhotra. All rights reserved.
//

import XCTest

class RAWUITests: XCTestCase {
        
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchEnvironment = ["RUNNING_UI_TESTS": "YES"]
        app.launch()
        setupSnapshot(app)
    }
    
    func test_Snapshot() {
        snapshot("0")
    }
    
}
