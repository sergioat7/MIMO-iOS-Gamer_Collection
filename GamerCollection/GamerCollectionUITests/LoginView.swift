//
//  LoginView.swift
//  GamerCollectionUITests
//
//  Created by Sergio Aragonés on 18/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest

class LoginView: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testLoginRight() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
        
        XCTAssert(app.textFields[localized("LOGIN_USERNAME")].title.isEmpty)
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].secureTextFields[localized("LOGIN_PASSWORD")].title.isEmpty)
        
        app.textFields[localized("LOGIN_USERNAME")].tap()
        
        let keyboard = app.keyboards
        keyboard.keys["t"].tap()
        keyboard.keys["e"].tap()
        keyboard.keys["s"].tap()
        keyboard.keys["t"].tap()
        
        app.keyboards.buttons["Return"].tap()
        
        keyboard.keys["t"].tap()
        keyboard.keys["e"].tap()
        keyboard.keys["s"].tap()
        keyboard.keys["t"].tap()
        
        app.buttons[localized("LOGIN_ACCESS").uppercased()].staticTexts[localized("LOGIN_ACCESS").uppercased()].tap()
    }

    func testLoginWrongWithNoPassword() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
        
        XCTAssert(app.textFields[localized("LOGIN_USERNAME")].title.isEmpty)
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].secureTextFields[localized("LOGIN_PASSWORD")].title.isEmpty)
        
        app.textFields[localized("LOGIN_USERNAME")].tap()
        
        let keyboard = app.keyboards
        keyboard.keys["t"].tap()
        keyboard.keys["e"].tap()
        keyboard.keys["s"].tap()
        keyboard.keys["t"].tap()
        
        app.buttons[localized("LOGIN_ACCESS").uppercased()].staticTexts[localized("LOGIN_ACCESS").uppercased()].tap()
        
        let errorDialog = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        XCTAssert(errorDialog.exists)
    }

    func testLoginWrongWithNoUserNorPassword() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
        
        XCTAssert(app.textFields[localized("LOGIN_USERNAME")].title.isEmpty)
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].secureTextFields[localized("LOGIN_PASSWORD")].title.isEmpty)
        
        app.buttons[localized("LOGIN_ACCESS").uppercased()].staticTexts[localized("LOGIN_ACCESS").uppercased()].tap()
        
        let errorDialog = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        XCTAssert(errorDialog.exists)
    }
    
    func testGoToRegister() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
        
        let buttonText = "\(localized("LOGIN_NOT_ACCOUNT"))\(localized("LOGIN_REGISTER"))"
        app.buttons[buttonText].staticTexts[buttonText].tap()
        
        XCTAssert(app.otherElements["Gamer_Collection.RegisterViewController"].exists)
    }
    
    // MARK: - Private functions
    
    private func localized(_ key: String) -> String {
        
        let uiTestBundle = Bundle(for: LoginView.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
}
