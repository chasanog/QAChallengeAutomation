//
//  BasicScenario.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 08.09.24.
//


import XCTest

/**
 This class is executing the Scenario given to place an order
 */
final class BasicScenario: XCTestCase {
    
    let wareHouseApp = XCUIApplication(bundleIdentifier: "com.sap.mobile.apps.WarehouseOperator.release")
    
    /// Initializing Helper
    let helper = HelperFunctions()
    
    /// checking if the app is started and ready to go by existence of the Demo Button
    func initial_Start_Of_Warehouse_App() -> Bool {
        let wareHousePageObject = WareHouseAppObjects(wareHouseApp)
        let demoButtonExists: Bool
        wareHousePageObject.wareHouseDismissButton.waitForExistence(timeout: 3) ? helper.checkExistenceWaitAndTap(wareHousePageObject.wareHouseDismissButton, 5) : ()
        demoButtonExists = wareHousePageObject.tryDemoButton.waitForExistence(timeout: 3)
        return demoButtonExists
    }
    
    /// Starting to place an order using helper functions
    /// - Returns: true if menu button exists for first page of Tasks
    func start_Order() -> Bool {
        let wareHousePageObject = WareHouseAppObjects(wareHouseApp)
        let menuButtonExists: Bool
        
        wareHousePageObject.tryDemoButton.tap()
        helper.checkExistenceWaitAndTap(wareHousePageObject.selectFromList, 3)
        helper.checkExistenceWaitAndTap(wareHousePageObject.claimMarcListItem, 3)
        helper.checkExistenceWaitAndTap(wareHousePageObject.putawayByHandlingButton, 3)
        helper.checkExistenceWaitAndTap(wareHousePageObject.keyboardLabel, 3)
        wareHouseApp.typeText("1000033504")
        helper.checkExistenceWaitAndTap(wareHousePageObject.wareHouseAlertOKButton, 3)
        helper.checkExistenceWaitAndTap(wareHousePageObject.startOrderButton, 3)
        
        menuButtonExists = wareHousePageObject.menuButton.waitForExistence(timeout: 3)
        return menuButtonExists
    }
    
    /// This function is used multiple times to enter data for every page in the scenario
    /// it either returns true when the next page appears with a menu button or the toast message is visible
    func fill_Verify_And_Confirm_Task_Page(_ textArray: [String]) -> Bool {
        let wareHousePageObject = WareHouseAppObjects(wareHouseApp)
        let menuButtonExists: Bool
        
        helper.enterAndVerifyManually(wareHousePageObject.menuButton, wareHousePageObject.verifyManuallyButton, textArray, wareHousePageObject.confirmManuallyButton)
        
        helper.checkExistenceWaitAndTap(wareHousePageObject.confirmTaskButton, 3)
        
        
        menuButtonExists = wareHousePageObject.menuButton.waitForExistence(timeout: 3)

        if menuButtonExists {
            return menuButtonExists
        } else if wareHousePageObject.toastMessage.waitForExistence(timeout: 5) {
            return true
        }
        return false
    }
    
    /// This function is similar to the "fill_Verify_And_Confirm_Task_Page" except we have to close a poping up window to continue
    /// - Returns true when menu button is visible
    func fill_Verify_And_Confirm_Task_Page_With_Close_Button(_ textArray: [String]) -> Bool {
        let wareHousePageObject = WareHouseAppObjects(wareHouseApp)
        let menuButtonExists: Bool
        
        helper.enterAndVerifyManually(wareHousePageObject.menuButton, wareHousePageObject.verifyManuallyButton, textArray, wareHousePageObject.confirmManuallyButton)
        
        helper.checkExistenceWaitAndTap(wareHousePageObject.closePopupButton, 3)
        
        menuButtonExists = wareHousePageObject.menuButton.waitForExistence(timeout: 3)
        
        return menuButtonExists
        
    }
}

