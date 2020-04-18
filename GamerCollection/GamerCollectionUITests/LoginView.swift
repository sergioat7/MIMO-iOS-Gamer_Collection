//
//  LoginView.swift
//  GamerCollectionUITests
//
//  Created by alumno on 18/04/2020.
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
        
        app.textFields[localized("LOGIN_USERNAME")].tap()
        app.keyboards.keys["t"].tap()
        app.keyboards.keys["e"].tap()
        app.keyboards.keys["s"].tap()
        app.keyboards.keys["t"].tap()
        
        app.keyboards.buttons["Return"].tap()
        
        app.keyboards.keys["t"].tap()
        app.keyboards.keys["e"].tap()
        app.keyboards.keys["s"].tap()
        app.keyboards.keys["t"].tap()
        
        app.buttons[localized("LOGIN_ACCESS").uppercased()].staticTexts[localized("LOGIN_ACCESS").uppercased()].tap()
    }

    func testLoginWrong() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.otherElements["Gamer_Collection.LoginViewController"].exists)
        
        app.textFields[localized("LOGIN_USERNAME")].tap()
        app.keyboards.keys["t"].tap()
        app.keyboards.keys["e"].tap()
        app.keyboards.keys["s"].tap()
        app.keyboards.keys["t"].tap()
        
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
