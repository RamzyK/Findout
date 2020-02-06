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
        addUIInterruptionMonitor(withDescription: "Allow “Findout” to access your location?") {
          (alert) -> Bool in
          snapshot("Map")
          alert.buttons["Allow While Using App"].tap()
          return true
        }

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test1SelectPlace(){
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()
        pKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"nombres\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"lettres\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey2.tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        aKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        lKey.tap()
        moreKey.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        moreKey2.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        mKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"suivant\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.children(matching: .secureTextField).element.tap()
        aKey.tap()
        pKey.tap()
        pKey.tap()
        lKey.tap()
        eKey.tap()
        pKey.tap()
        aKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        sKey.tap()
        
        let wKey = app/*@START_MENU_TOKEN@*/.keys["w"]/*[[".keyboards.keys[\"w\"]",".keys[\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        wKey.tap()
        oKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"terminé\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons[localizedString(key: "login.loginButtonLabel")].tap()
        
        app.tables["Empty list"]/*@START_MENU_TOKEN@*/.buttons["Sport"]/*[[".otherElements.matching(identifier: \"+\").buttons[\"Sport\"]",".buttons[\"Sport\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Football"]/*[[".cells.staticTexts[\"Football\"]",".staticTexts[\"Football\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        snapshot("Map")
        sleep(2)
        app.otherElements["La Campagne"].tap()
        snapshot("Detail")
        app.buttons["La Campagne"].tap()
        app.buttons["close bottom sheet"].tap()
    }
    
    
    func test2HomeScreen(){
        snapshot("Login Screen")
    }
    
    func test3SignupScreen(){
        let app = XCUIApplication()

        app.buttons[localizedString(key: "login.signupButtonLabel")].tap()
        snapshot("Sign up Screen")
        app/*@START_MENU_TOKEN@*/.buttons["✕"]/*[[".scrollViews.buttons[\"✕\"]",".buttons[\"✕\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["✕"].tap()
    }
    
    func test4LoginForm(){
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.typeText("apple@gmail.com")

        let secureTextField = element.children(matching: .secureTextField).element

        secureTextField.tap()
        secureTextField.tap()
        secureTextField.typeText("applepassword")

        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"terminé\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        doneButton.tap()
        sleep(1)
        snapshot("Login Form")

        app.buttons[localizedString(key: "login.loginButtonLabel")].tap()
        sleep(1)
        snapshot("Activities screen")
    }
    
    func test5SignUpForm(){
        
        let app = XCUIApplication()
        app.buttons[localizedString(key: "login.signupButtonLabel")].tap()
        
        let signUpElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier:localizedString(key: "login.signupButtonLabel"))
        signUpElementsQuery.children(matching: .textField).element(boundBy: 0).tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        tKey.tap()
        
        let nextButton = app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"next\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        nextButton.tap()
        signUpElementsQuery.children(matching: .textField).element(boundBy: 1).tap()
        tKey.tap()
        eKey.tap()
        sKey.tap()
        tKey.tap()

        nextButton.tap()
        tKey.tap()
        eKey.tap()
        sKey.tap()
        tKey.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        mKey.tap()
        nextButton.tap()
        
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        nextButton.tap()
        
        let datePickersQuery = app2.datePickers
        let now = Calendar.current.dateComponents(in: .current, from: Date())

        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        datePickersQuery.pickerWheels[today.day!.description].swipeUp()
        
        let toolbar = app.toolbars["Toolbar"]
        toolbar.buttons["Next"].tap()
        
        let key3 = app2/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()
        key3.tap()

        toolbar.buttons["Done"].tap()
        snapshot("Sign up Form")
        sleep(1)
        
    }
    
    func test6ActivityChoice(){
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.typeText("apple@gmail.com")

        let secureTextField = element.children(matching: .secureTextField).element

        secureTextField.tap()
        secureTextField.tap()
        secureTextField.typeText("applepassword")

        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"terminé\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        doneButton.tap()

        app.buttons[localizedString(key: "login.loginButtonLabel")].tap()
        sleep(1)
        snapshot("Activities screen")
        
        app.tables["Empty list"]/*@START_MENU_TOKEN@*/.buttons["Sport"]/*[[".otherElements.matching(identifier: \"+\").buttons[\"Sport\"]",".buttons[\"Sport\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Football"]/*[[".cells.staticTexts[\"Football\"]",".staticTexts[\"Football\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                
    }
    
    func localizedString(key:String) -> String {
          let languageBundlePath = Bundle(for: FindoutUITests.self).path(forResource: deviceLanguage, ofType: "lproj") ?? Bundle(for: FindoutUITests.self).path(forResource: NSLocale.current.languageCode!, ofType: "lproj")
          let localizationBundle = Bundle(path: languageBundlePath!)
          let result = NSLocalizedString(key, bundle:localizationBundle!, comment: "")
        return result
    }
    
    /*func testMapScreen(){
        
    }
    
    func testAuthorization(){
        
    }
    
    
    func testShowMoreOnPlace(){
        
    }
    
    func testSharePlace(){
        
    }
    
    func testAddPlace(){
        
    }
    
    func testSelectDispo(){
        
    }
    
    func testAddPlaceWithNoField(){
        
    }
    
    func testAddDispoWithNoField(){
        
    }
     
     func testLaunchPerformance() {
         if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
             // This measures how long it takes to launch your application.
             measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                 XCUIApplication().launch()
             }
         }
     }*/
     
    
    
//    func testExample() {
//        // UI tests must launch the application that they test.
//        //let localizationBundle = localizedString(key: "signup.signupButtonLabel")
//
//      snapshot("Login Screen")
//        let app = XCUIApplication()
//
//
//        app.buttons[localizedString(key: "login.signupButtonLabel")].tap()
//        snapshot("Sign up Screen")
//
//        app/*@START_MENU_TOKEN@*/.buttons["✕"]/*[[".scrollViews.buttons[\"✕\"]",".buttons[\"✕\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["✕"].tap()
//
//        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//
//        let textField = element.children(matching: .textField).element
//        textField.tap()
//        textField.tap()
//        textField.typeText("rmz@gmail.com")
//
//        let secureTextField = element.children(matching: .secureTextField).element
//
//        secureTextField.tap()
//        secureTextField.tap()
//        secureTextField.typeText("azertyuiop")
//
//        let doneButton = app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"terminé\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        doneButton.tap()
//
//        app.buttons[localizedString(key: "login.loginButtonLabel")].tap()
//
//
//        let collectionViewsQuery = app.collectionViews
//
//        snapshot("Activities screen")
//        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
//        snapshot("Categories screen")
//        collectionViewsQuery.cells.children(matching: .other).element.children(matching: .other).element.tap()
//        snapshot("Map Screen")
//
//
////        app.alerts["Autoriser « Findout » à accéder à votre position ?"].scrollViews.otherElements.buttons["Autoriser lorsque l’app est active"].tap()
////        app.otherElements["KELBAY"].tap()
////
////        snapshot("Map Screen with bottom - sheet")
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
}
