//
//  RegisterView.swift
//  GamerCollectionUITests
//
//  Created by Sergio Aragonés on 19/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest

class RegisterView: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testRegisterWrongWithNoPasswords() throws {
        
        showRegisterView()
        initialCheking()
        
        app.textFields[localized("REGISTRATION_USERNAME")].tap()
        
        let keyboard = app.keyboards
        keyboard.keys["t"].tap()
        keyboard.keys["e"].tap()
        keyboard.keys["s"].tap()
        keyboard.keys["t"].tap()
        
        let returnButton = app.keyboards.buttons["Return"]
        returnButton.tap()
        returnButton.tap()
        returnButton.tap()
                
        let errorDialog = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        XCTAssert(errorDialog.exists)
    }
    
    func testRegisterWrongWithNoMatchingPasswords() throws {
        
        showRegisterView()
        initialCheking()
        
        app.textFields[localized("REGISTRATION_USERNAME")].tap()
        
        let keyboard = app.keyboards
        keyboard.keys["t"].tap()
        keyboard.keys["e"].tap()
        keyboard.keys["s"].tap()
        keyboard.keys["t"].tap()
        
        let returnButton = app.keyboards.buttons["Return"]
        returnButton.tap()
        
        app.otherElements["Gamer_Collection.RegisterViewController"].secureTextFields[localized("REGISTRATION_PASSWORD")].tap()
        
        keyboard.keys["t"].tap()
        keyboard.keys["e"].tap()
        keyboard.keys["s"].tap()
        keyboard.keys["t"].tap()
        
        returnButton.tap()
        returnButton.tap()
        
        let errorDialog = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        XCTAssert(errorDialog.exists)
    }
    
    func testRegisterWrongWithNoUserNorPasswords() throws {
        
        showRegisterView()
        initialCheking()
                
        app.otherElements["Gamer_Collection.RegisterViewController"].buttons[localized("REGISTER").uppercased()].staticTexts[localized("REGISTER").uppercased()].tap()
        
        let errorDialog = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        XCTAssert(errorDialog.exists)
    }
    
    func testGoBackToLogin() throws {
        
        showRegisterView()
        initialCheking()
        
        app.navigationBars[localized("REGISTRATION")].buttons[localized("BACK")].tap()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
    }
    
    // MARK: - Private functions
    
    private func showRegisterView() {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
        
        let buttonText = "\(localized("LOGIN_NOT_ACCOUNT"))\(localized("LOGIN_REGISTER"))"
        app.buttons[buttonText].staticTexts[buttonText].tap()
        
        XCTAssert(app.otherElements["Gamer_Collection.RegisterViewController"].exists)
    }
    
    private func initialCheking() {
        
        XCTAssert(app.navigationBars[localized("REGISTRATION")].staticTexts[localized("REGISTRATION")].label == localized("REGISTRATION"))
        
        XCTAssert(app.textFields[localized("REGISTRATION_USERNAME")].title.isEmpty)
        XCTAssert(app.otherElements["Gamer_Collection.RegisterViewController"].secureTextFields[localized("REGISTRATION_PASSWORD")].title.isEmpty)
        XCTAssert(app.otherElements["Gamer_Collection.RegisterViewController"].secureTextFields[localized("REGISTRATION_REPEAT_PASSWORD")].title.isEmpty)
    }
    
    private func localized(_ key: String) -> String {
        
        let uiTestBundle = Bundle(for: LoginView.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
}
