//
//  AppStoreObjects.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 04.09.24.
//

import XCTest

/**
 This class is used for the Objects of the App App Store to locate elements
 */
final class AppStoreObjects {
      
    let searchTab: XCUIElement 
    let searchTextField: XCUIElement
    let keyBoardSearchButton: XCUIElement
    let openButton: XCUIElement
    let appSearchResultCell: XCUIElement
    let getButton: XCUIElement
    let reDownloadButton: XCUIElement
    let appStoreNavBarSignIn: XCUIElement
    let alertNotNowButton: XCUIElement
    let alertAlwaysRequireButton: XCUIElement
    
    required init(_ appStore: XCUIApplication) {
        self.searchTab = appStore.tabBars.buttons["Search"]
        self.searchTextField = appStore.searchFields["AppStore.searchField"]
        self.keyBoardSearchButton = appStore.keyboards.buttons["Search"]
        self.appSearchResultCell = appStore.cells.containing(.button, identifier: "SAP Warehouse Operator, Business").firstMatch
        self.openButton = appSearchResultCell.buttons["AppStore.offerButton[state=open]"]
        self.getButton = appSearchResultCell.buttons["AppStore.offerButton[state=get]"]
        self.reDownloadButton = appSearchResultCell.buttons["AppStore.offerButton[state=redownload]"]
        self.appStoreNavBarSignIn = appStore.navigationBars["AKBasicLoginView"].buttons["Sign In"]
        self.alertNotNowButton = appStore.buttons["Not Now"]
        self.alertAlwaysRequireButton = appStore.alerts.buttons["Always Require"]
        
    }
    
}
