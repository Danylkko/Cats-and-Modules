//
//  CatsAndModulesUITests.swift
//  CatsAndModulesUITests
//
//  Created by Danylo Litvinchuk on 08.07.2022.
//

import XCTest

class CatsAndModulesUITests: XCTestCase {
    
    func testahahha() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        sleep(4)
        
        snapshot("DanyloLitvinchuk_MainScreen")
        
        let _ = app.otherElements["mainTable"].tap()
        
        sleep(4)
        
        snapshot("DanyloLitvinchuk_DetailsScreen")
    }
    
}
