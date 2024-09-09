//
//  DownloadAndInstall.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 08.09.24.
//

import XCTest

/**
 This class is executing the Download and Install process where it differentiates between different possible scenarios
 1. There is no account logged in so we login and download the app
 2. There is an account logged in but it requires a password to install
 3. The app has been downloaded previously and we can redownload without authentication
 4. The app is installed already so we open the app from the app store directly
 */
final class DownloadAndInstall: XCTestCase {
    
    // Authentication Data is stored in Scheme Arguments
    let email = ProcessInfo.processInfo.environment["EMAIL"] ?? ""
    let password = ProcessInfo.processInfo.environment["PASSWORD"] ?? ""
    let appStore = XCUIApplication(bundleIdentifier: "com.apple.AppStore")
    let springBoard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    let helper = HelperFunctions()
    
    /**
     This function is downloading the app and returns true once app is launched
     - Returns: true if the app is opened successfully
     */
    func download_And_Install_WareHouse_App() -> Bool {
        let appStorePageObject = AppStoreObjects(appStore)
        let springBoardPageObjects = SpringBoardObjects(springBoard)
        
        appStore.launch()
        helper.checkExistenceWaitAndTap(appStorePageObject.searchTab, 10)
        appStorePageObject.searchTextField.typeText("SAP Warehouse Operator")
        helper.checkExistenceWaitAndTap(appStorePageObject.keyBoardSearchButton, 10)
        
        // making sure we have the correct search results
        XCTAssertTrue(appStorePageObject.appSearchResultCell.waitForExistence(timeout: 5), "The label for SAP Warehouse Operator could not be found")
        
        // Installing the app according to the current state of authentication required
        if(appStorePageObject.getButton.waitForExistence(timeout: 5)) {
            appStorePageObject.getButton.tap()
            
            if(springBoardPageObjects.springBoardInstallButton.waitForExistence(timeout: 5)) {
                springBoardPageObjects.springBoardInstallButton.tap()
                springBoard.typeText(password)
                springBoardPageObjects.springBoardSignIn.tap()
                if appStorePageObject.alertNotNowButton.waitForExistence(timeout: 10) {
                    helper.checkExistenceWaitAndTap(appStorePageObject.alertNotNowButton, 0)
                }
                if appStorePageObject.alertAlwaysRequireButton.waitForExistence(timeout: 10) {
                    helper.checkExistenceWaitAndTap(appStorePageObject.alertAlwaysRequireButton, 0)
                }
                
            } else {
                appStore.typeText(email)
                helper.checkExistenceWaitAndTap(appStorePageObject.appStoreNavBarSignIn, 10)
                appStore.typeText(password)
                helper.checkExistenceWaitAndTap(appStorePageObject.appStoreNavBarSignIn, 10)
                helper.checkExistenceWaitAndTap(springBoardPageObjects.springBoardInstallButton, 30)
                if appStorePageObject.alertNotNowButton.waitForExistence(timeout: 10) {
                    helper.checkExistenceWaitAndTap(appStorePageObject.alertNotNowButton, 0)
                }
                if appStorePageObject.alertAlwaysRequireButton.waitForExistence(timeout: 10) {
                    helper.checkExistenceWaitAndTap(appStorePageObject.alertAlwaysRequireButton, 0)
                }
            }
            helper.checkExistenceWaitAndTap(appStorePageObject.openButton, 30)
            return true
        } else if (appStorePageObject.reDownloadButton.exists) {
            appStorePageObject.reDownloadButton.tap()
            helper.checkExistenceWaitAndTap(appStorePageObject.openButton, 30)
            return true
        } else {
            helper.checkExistenceWaitAndTap(appStorePageObject.openButton, 30)
            return true
        }
    }
}
