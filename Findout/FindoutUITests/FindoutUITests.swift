//
//  FindoutUITests.swift
//  FindoutUITests
//
//  Created by Ramzy Kermad on 27/01/2020.
//  Copyright © 2020 Ramzy Kermad. All rights reserved.
//

import XCTest

class FindoutUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func localizedString(key:String) -> String {
          let languageBundlePath = Bundle(for: FindoutUITests.self).path(forResource: deviceLanguage, ofType: "lproj") ?? Bundle(for: FindoutUITests.self).path(forResource: NSLocale.current.languageCode!, ofType: "lproj")
          let localizationBundle = Bundle(path: languageBundlePath!)
          let result = NSLocalizedString(key, bundle:localizationBundle!, comment: "")
        return result
    }

    func testExample() {
        // UI tests must launch the application that they test.
        //let localizationBundle = localizedString(key: "signup.signupButtonLabel")

      snapshot("Login Screen")
        let app = XCUIApplication()

        
        app.buttons[localizedString(key: "login.signupButtonLabel")].tap()
        snapshot("Sign up Screen")
        
        app/*@START_MENU_TOKEN@*/.buttons["✕"]/*[[".scrollViews.buttons[\"✕\"]",".buttons[\"✕\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["✕"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.typeText("rmz@gmail.com")
        
        let secureTextField = element.children(matching: .secureTextField).element
        
        secureTextField.tap()
        secureTextField.tap()
        secureTextField.typeText("azertyuiop")
        
        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"terminé\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        doneButton.tap()
        
        app.buttons[localizedString(key: "login.loginButtonLabel")].tap()
        
        
        let collectionViewsQuery = app.collectionViews
        
        snapshot("Activities screen")
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
        snapshot("Categories screen")
        collectionViewsQuery.cells.children(matching: .other).element.children(matching: .other).element.tap()
        snapshot("Map Screen")

        
//        app.alerts["Autoriser « Findout » à accéder à votre position ?"].scrollViews.otherElements.buttons["Autoriser lorsque l’app est active"].tap()
//        app.otherElements["KELBAY"].tap()
//
//        snapshot("Map Screen with bottom - sheet")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
