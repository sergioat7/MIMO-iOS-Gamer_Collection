//
//  RegisterDataManagerTests.swift
//  GamerCollectionTests
//
//  Created by Sergio Aragonés on 19/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
@testable import Gamer_Collection

class RegisterDataManagerTests: XCTestCase {
    
    var sut: RegisterDataManager!
    var userManager = UserManager()

    override func setUpWithError() throws {
        
        super.setUp()
        sut = RegisterDataManager(apiClient: RegisterApiClient(),
                                  loginApiClient: LoginApiClient(userManager: userManager),
                                  userManager: userManager,
                                  formatRepository: FormatRepository(),
                                  genreRepository: GenreRepository(),
                                  platformRepository: PlatformRepository(),
                                  stateRepository: StateRepository())
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }
    
    func testRegisterExistantUser() throws {
        
        var error: ErrorResponse?
        
        let promise = expectation(description: "Register unsuccessfull")
        sut.register(username: "test", password: "test", success: {
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(error)
    }

    func testLoginRight() throws {
        
        var token: String?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Login successfull")
        sut.login(username: "test", password: "test", success: { loginResponse in
            
            token = loginResponse.token
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(token)
        XCTAssertTrue(!token!.isEmpty)
        XCTAssertNil(error)
    }

    func testLoginWrong() throws {
                
        var token: String?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Login unsuccessfull")
        sut.login(username: "test", password: "test123", success: { loginResponse in
            
            token = loginResponse.token
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNil(token)
        XCTAssertNotNil(error)
    }

    func testStoreUserData() throws {
        
        var userData: UserData?
        var error: ErrorResponse?
        
        sut.storeUserData(userData: UserData(userName: "test",
                                             password: "test",
                                             isLoggedIn: true))
        
        let promise = expectation(description: "Store user data")
        userManager.getUserData(success: { userDataResponse in
            
            userData = userDataResponse
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        userManager.removeUserData()
        
        XCTAssertNotNil(userData)
        XCTAssertEqual(userData?.userName, "test")
        XCTAssertEqual(userData?.password, "test")
        XCTAssertNil(error)
    }

    func testStoreCredentials() throws {
        
        var authData: AuthData?
        var error: ErrorResponse?
        
        sut.storeCredentials(authData: AuthData(token: "token"))
        
        let promise = expectation(description: "Store credentials")
        userManager.getCredentials(success: { authDataResponse in
            
            authData = authDataResponse
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        userManager.removeCredentials()
        
        XCTAssertNotNil(authData)
        XCTAssertEqual(authData?.token, "token")
        XCTAssertNil(error)
    }

    func testGetFormats() throws {
        
        var formats: FormatsResponse?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get formats")
        sut.getFormats(success: { formatsResponse in
            
            formats = formatsResponse
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(formats)
        XCTAssertTrue(!formats!.isEmpty)
        XCTAssertNil(error)
    }

    func testGetGenres() throws {
        
        var genres: GenresResponse?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get genres")
        sut.getGenres(success: { genresResponse in
            
            genres = genresResponse
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(genres)
        XCTAssertTrue(!genres!.isEmpty)
        XCTAssertNil(error)
    }

    func testGetPlatforms() throws {
        
        var platforms: PlatformsResponse?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get platforms")
        sut.getPlatforms(success: { platformsResponse in
            
            platforms = platformsResponse
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(platforms)
        XCTAssertTrue(!platforms!.isEmpty)
        XCTAssertNil(error)
    }

    func testGetStates() throws {
        
        var states: StatesResponse?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get states")
        sut.getStates(success: { statesResponse in
            
            states = statesResponse
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(states)
        XCTAssertTrue(!states!.isEmpty)
        XCTAssertNil(error)
    }
}
