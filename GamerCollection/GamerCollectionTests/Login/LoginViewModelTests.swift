//
//  LoginViewModelTests.swift
//  GamerCollectionTests
//
//  Created by Sergio Aragonés on 18/04/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
@testable import Gamer_Collection

class LoginViewModelTests: XCTestCase {
    
    var sut: LoginViewModelProtocol!
    var userManager: UserManager!
    var view: LoginViewController!

    override func setUpWithError() throws {
        
        super.setUp()
        userManager = UserManager()
        let dataManager = LoginDataManager(apiClient: LoginApiClient(userManager: userManager),
                                           userManager: userManager,
                                           formatRepository: FormatRepository(),
                                           genreRepository: GenreRepository(),
                                           platformRepository: PlatformRepository(),
                                           stateRepository: StateRepository(),
                                           gameRepository: GameRepository(),
                                           sagaRepository: SagaRepository())
        if let vc = UIStoryboard(name: "LoginView", bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            view = vc
        } else {
            view = LoginViewController()
        }
        sut = LoginViewModel(view: view,
                             dataManager: dataManager)
    }

    override func tearDownWithError() throws {
        
        sut = nil
        view = nil
        userManager = nil
        super.tearDown()
    }

    func testViewDidLoad1() throws {
        
        userManager.removeUserData()
        
        sut.viewDidLoad()
        XCTAssertEqual(view.tfUsername.text, "")
        XCTAssertEqual(view.tfPassword.text, "")
    }

    func testViewDidLoad2() throws {
        
        userManager.storeUserData(userData: UserData(userName: "test",
                                                     password: "test",
                                                     isLoggedIn: true))
        
        sut.viewDidLoad()
        XCTAssertEqual(view.tfUsername.text, "test")
        XCTAssertEqual(view.tfPassword.text, "")
        
        userManager.removeUserData()
    }

    func testGoToRegisterView() throws {
        
        sut.register()
        XCTAssertTrue(UIViewController.getCurrentViewController().self is RegisterViewController)
    }
}
