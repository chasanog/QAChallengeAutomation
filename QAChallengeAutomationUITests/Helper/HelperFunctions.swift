//
//  HelperFunctions.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 08.09.24.
//

import XCTest

/**
 This class has helper functions which are dynamically usable in any scenario
 */
class HelperFunctions {
    let wareHouseApp = XCUIApplication(bundleIdentifier: "com.sap.mobile.apps.WarehouseOperator.release")
    
    /**
    checkExistenceWaitAndTap is used for checking the existence of a UI Element and waiting for the given Time Interval to avoid execution before Element appears
    @param uiElement locates the XCUIElement
    @param timeout given TimerInterval for how long to wait
     */
    func checkExistenceWaitAndTap(_ uiElement: XCUIElement, _ timeout: TimeInterval) {
        XCTAssertTrue(uiElement.waitForExistence(timeout: timeout), "\(uiElement) does not Exist")
        uiElement.tap()
    }
    
    /**
     enterAndVerifyManually is used to enter data into Tasks manually and validate
     @param menuButton used to open menu
     @param verifyManuallyButton is a menu item pressed when menuButton is pressed
     @param textToEnter is an array of Strings for which this function is being executed and filled until the confirm button appears
     @param confirmButton is pressed when everything entered successfully
     */
    func enterAndVerifyManually(_ menuButton: XCUIElement, _ verifyManuallyButton: XCUIElement, _ textToEnter: [String], _ confirmButton: XCUIElement) {
        for text in textToEnter {
            checkExistenceWaitAndTap(menuButton, 3)
            checkExistenceWaitAndTap(verifyManuallyButton, 3)
            wareHouseApp.typeText(text)
            checkExistenceWaitAndTap(confirmButton, 3)
        }
        
    }
    
}
