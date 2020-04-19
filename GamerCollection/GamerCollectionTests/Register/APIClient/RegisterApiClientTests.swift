//
//  RegisterApiClientTests.swift
//  GamerCollectionTests
//
//  Created by Sergio Aragonés on 19/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
@testable import Gamer_Collection

class RegisterApiClientTests: XCTestCase {

    var sut: RegisterApiClient!
    
    override func setUpWithError() throws {
        
        super.setUp()
        sut = RegisterApiClient()
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }
    
    func testRegisterExistantUser() throws {
        
        var error: ErrorResponse?
        
        let promise = expectation(description: "Login successfull")
        sut.register(username: "test", password: "test", success: { _ in
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(error)
    }
}
