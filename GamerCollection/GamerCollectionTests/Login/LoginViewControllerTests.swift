//
//  LoginViewControllerTests.swift
//  GamerCollectionTests
//
//  Created by Sergio Aragonés on 18/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
@testable import Gamer_Collection

class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!

    override func setUpWithError() throws {
        
        super.setUp()
        if let view = UIStoryboard(name: "LoginView", bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            sut = view
        } else {
            sut = LoginViewController()
        }
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }

    func testView() throws {
        
        sut.viewDidLoad()
        XCTAssertEqual(sut.view.backgroundColor, Color.color1)
        XCTAssertNil(sut.navigationItem.title)
        XCTAssertNil(sut.navigationController?.navigationBar)
    }
}
