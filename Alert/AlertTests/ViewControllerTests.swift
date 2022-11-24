//
//  ViewControllerTests.swift
//  AlertTests
//
//  Created by Ayemere  Odia  on 2022/11/24.
//

import XCTest
import ViewControllerPresentationSpy
@testable import Alert

class ViewControllerTests: XCTestCase {

    private var alertVerifer: AlertVerifier!
    private var sut : ViewController?
    
    override func setUp() {
        super.setUp()
        alertVerifer = AlertVerifier()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
    }
    
    override func tearDown() {
        alertVerifer = nil
        sut = nil
        super.tearDown()
    }

    func test_tappingButton_shouldShowAlert() {
        
        sut?.loadViewIfNeeded()
        guard let button = sut?.button else {
            XCTFail("Button does not exist")
            return
        }
        
        tap(button)
        
        alertVerifer.verify(
            title: "Do the thing?",
            message: "Let us know if you want to do the thing",
            animated: true,
            actions: [.cancel("Cancel"), .default("Ok")],
            preferredStyle: .alert,
            presentingViewController: sut)
        
        XCTAssertEqual(alertVerifer.preferredAction?.title, "Ok", "preferred action")
    }
    
    func test_executeAlertAction_withOKButton() throws {
        sut?.loadViewIfNeeded()
        guard let button = sut?.button else {
            XCTFail("Button does not exist")
            return
        }
        
        tap(button)
        
        try alertVerifer.executeAction(forButton: "Ok")
    }
}
