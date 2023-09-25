//
//  SocialNetworkUITestsLaunchTests.swift
//  SocialNetworkUITests
//
//  Created by MahmoudFares on 18/09/2023.
//

@testable import App
@testable import SharedUI

import XCTest
final class SocialNetworkUITestsLaunchTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()

        setupSnapshot(app)
        app.launch()
    }

    func testExample()  {
        snapshot("login")
        let usernameTF = app.textFields["usernameTextField"]
        let passwordTF = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        usernameTF.typeText("kminchelle")
        passwordTF.tap()
        passwordTF.typeText("0lelplR")
        loginButton.tap()
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: usernameTF
        )
        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        snapshot("posts")
    }
}
