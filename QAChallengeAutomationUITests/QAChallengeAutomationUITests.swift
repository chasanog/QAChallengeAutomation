//
//  QAChallengeAutomationUITests.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 30.08.24.
//

import XCTest

/**
 This Test Class is covering the Basic Scenario of the given Coding Challenge for Automation Setup and Test Execution for SAP Warehouse Operator app
 */
final class QAChallengeAutomationUITests: XCTestCase {
    
    let appStore = XCUIApplication(bundleIdentifier: "com.apple.AppStore")
    let wareHouseApp = XCUIApplication(bundleIdentifier: "com.sap.mobile.apps.WarehouseOperator.release")
    let springBoard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
    let appName = "SAP Warehouse Operator"
    
    var skipTeardown = false

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    /**
     Testing Download of SAP Warehouse Operator app and Installation
     Succeeds if the SAP Warehouse App is opened after downloading from the App Store
     It covers all possible ways of exection (logged in, redownload, first download)
     skipTeardown is used because the Ware House app will close if not set to true
     */
    func test_A_Download_And_Install() {
        defer { skipTeardown = true }
        XCTAssertTrue(DownloadAndInstall().download_And_Install_WareHouse_App(), "Could not download and install Warehouse app")
    }
    
    /**
     Testing the Scenario given End to End until reaching the toast message "Order completed"
     */
    func test_B_Basic_Scenario() {
        let wareHousePageObject = WareHouseAppObjects(wareHouseApp)
        
        
        // this is used if only this testcase is going to be tested or the app closes for any reason
        if wareHouseApp.state == .runningForeground || wareHouseApp.state == .runningBackground {
            print("App is already running. Attaching to the existing instance.")
        } else {
            // If the app is not running, we launch it
            print("App is not running. Launching it now.")
            wareHouseApp.launch()
        }
        let screenshot = wareHouseApp.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        
        // This will dismiss the alert of initial start and check if Try Demo Button does exist
        XCTAssertTrue(BasicScenario().initial_Start_Of_Warehouse_App(), "Warehouse App did not start")
        
        // This will press the Try Demo Button and run steps until we Start the Order
        XCTAssertTrue(BasicScenario().start_Order(), "Order could not be started")
        
        // The next line will fill 1/3 Pages of Tasks with given data and confirm
        XCTAssertTrue(BasicScenario().fill_Verify_And_Confirm_Task_Page(["4583189","T202-01-01"]), "First batch of Tasks could not be set up")
        
        // The next line will fill 2/3 Pages of Tasks with given data and confirm
        XCTAssertTrue(BasicScenario().fill_Verify_And_Confirm_Task_Page(["20146","T202-01-02"]), "Second batch of Tasks could not be set up")
        
        // The next two linse will fill 3/3 Pages of Tasks with given data and confirm with closing a popup
        XCTAssertTrue(BasicScenario().fill_Verify_And_Confirm_Task_Page_With_Close_Button(["4623767"]), "Last batch of Tasks could not be set up")
        XCTAssertTrue(BasicScenario().fill_Verify_And_Confirm_Task_Page(["100001", "100002", "100003", "T202-01-03"]), "Last batch of Tasks could not be set up")
        
        
        let toastMessageExists = wareHousePageObject.toastMessage.waitForExistence(timeout: 5)
        
        attachment.name = "Toast Message displayed"
        attachment.lifetime = .keepAlways
        add(attachment)
        // Confirming that the Order Completed Toast message appeared successfully
        XCTAssertTrue(toastMessageExists, "Toast message did not appear")
        
        
    }

    
    override func tearDown() {
        if skipTeardown {
            return
        }
        appStore.terminate()
        wareHouseApp.terminate()
        super.tearDown()
    }

}
