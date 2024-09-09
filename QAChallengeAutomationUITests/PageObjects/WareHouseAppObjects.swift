//
//  WareHouseAppObjects.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 04.09.24.
//

import XCTest
/**
 This class is used for the Objects of the SAP Warehouse Operator app to locate elements
 */
final class WareHouseAppObjects {
    
    let tryDemoButton: XCUIElement
    let selectFromList: XCUIElement
    let claimMarcListItem: XCUIElement
    let putawayByHandlingButton: XCUIElement
    let navigationBarPutaway: XCUIElement
    let keyboardLabel: XCUIElement
    
    let menuButton: XCUIElement
    
    let verifyManuallyButton: XCUIElement
    let confirmManuallyButton: XCUIElement
    
    let startOrderButton: XCUIElement
    
    let toastMessage: XCUIElement
    let confirmTaskButton: XCUIElement
    
    let closePopupButton: XCUIElement
    
    let wareHouseAlertOKButton: XCUIElement
    
    let wareHouseDismissButton: XCUIElement
    
    required init(_ wareHouseApp: XCUIApplication) {
        self.tryDemoButton = wareHouseApp.buttons["footnoteActionButton"]
        self.selectFromList = wareHouseApp.cells["selectResourceCell"]
        self.claimMarcListItem = wareHouseApp.cells["ResourceInfo.MARC"]
        self.putawayByHandlingButton = wareHouseApp.cells["putaway.putawayHandlingUnit"]
        self.navigationBarPutaway = wareHouseApp.navigationBars["Putaway"]
        self.keyboardLabel = navigationBarPutaway.buttons["Keyboard"]
        self.menuButton = wareHouseApp.buttons["menuButton"]
        self.verifyManuallyButton = wareHouseApp.buttons["menuButton_Verify Manually"]
        self.confirmManuallyButton = wareHouseApp.alerts.buttons["OK"]
        self.startOrderButton = wareHouseApp.buttons["startOrderButton"]
        self.toastMessage = wareHouseApp.staticTexts["Toast Message Order completed"]
        self.confirmTaskButton = wareHouseApp.buttons["confirmTaskButton"]
        self.closePopupButton = wareHouseApp.buttons["Close"]
        self.wareHouseAlertOKButton = wareHouseApp.alerts.buttons["OK"]
        self.wareHouseDismissButton = wareHouseApp.buttons["Dismiss"]
    }
    
}
