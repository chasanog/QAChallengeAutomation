//
//  SpringBoardObjects.swift
//  QAChallengeAutomationUITests
//
//  Created by Hasanoglu, Cihan on 08.09.24.
//
import XCTest
/*
 This class is used for the Objects of the Springboard such as Install Splashscreen in the app store
 */
final class SpringBoardObjects {
    
    let springBoardInstallButton: XCUIElement
    let springBoardSignIn: XCUIElement
    
    
    required init(_ springBoard: XCUIApplication) {
        self.springBoardInstallButton = springBoard.buttons["Install"]
        self.springBoardSignIn = springBoard.buttons["Sign In"]
        
    }
    
}
