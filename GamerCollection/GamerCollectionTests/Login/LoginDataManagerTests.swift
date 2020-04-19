//
//  LoginDataManagerTests.swift
//  GamerCollectionTests
//
//  Created by Sergio Aragonés on 18/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
@testable import Gamer_Collection

class LoginDataManagerTests: XCTestCase {
    
    var sut: LoginDataManager!
    var userManager = UserManager()

    override func setUpWithError() throws {
        
        super.setUp()
        sut = LoginDataManager(apiClient: LoginApiClient(userManager: userManager),
                               userManager: userManager,
                               formatRepository: FormatRepository(),
                               genreRepository: GenreRepository(),
                               platformRepository: PlatformRepository(),
                               stateRepository: StateRepository(),
                               gameRepository: GameRepository(),
                               sagaRepository: SagaRepository())
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }

    func testGetUsernameRight() throws {
        
        var user: String?
        var error: ErrorResponse?
        
        userManager.storeUserData(userData: UserData(userName: "test",
                                                     password: "test",
                                                     isLoggedIn: true))
        
        let promise = expectation(description: "Login successfull")
        sut.getUsername(success: { username in
            
            user = username
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        userManager.removeUserData()
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user, "test")
        XCTAssertNil(error)
    }

    func testGetUsernameWrong() throws {
        
        var user: String?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Login successfull")
        sut.getUsername(success: { username in
            
            user = username
            promise.fulfill()
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNil(user)
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

    func testGetGames() throws {
        
        var games: GamesResponse?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get games")
        sut.login(username: "test", password: "test", success: { loginResponse in
            
            self.userManager.storeCredentials(authData: AuthData(token: loginResponse.token))
            self.sut.getGames(success: { gamesResponse in
                
                games = gamesResponse
                promise.fulfill()
            }, failure: { errorResponse in
                
                error = errorResponse
                promise.fulfill()
            })
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(games)
        XCTAssertNil(error)
    }

    func testGetSagas() throws {
        
        var sagas: SagasResponse?
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get sagas")
        sut.login(username: "test", password: "test", success: { loginResponse in
            
            self.userManager.storeCredentials(authData: AuthData(token: loginResponse.token))
            self.sut.getSagas(success: { sagasResponse in
                
                sagas = sagasResponse
                promise.fulfill()
            }, failure: { errorResponse in
                
                error = errorResponse
                promise.fulfill()
            })
        }, failure: { errorResponse in
            
            error = errorResponse
            promise.fulfill()
        })
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(sagas)
        XCTAssertNil(error)
    }
}
