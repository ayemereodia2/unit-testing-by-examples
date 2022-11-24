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
    
    override func setUp() {
        super.setUp()
        alertVerifer = AlertVerifier()
    }
    
    override func tearDown() {
        alertVerifer = nil
        super.tearDown()
    }

    func test_tappingButton_shouldShowAlert() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        sut.loadViewIfNeeded()
        
        tap(sut.button)
        
        alertVerifer.verify(
            title: "Do the thing?",
            message: "Let us know if you want to do the thing",
            animated: true,
            actions: [.cancel("Cancel"), .default("Ok")],
            preferredStyle: .alert,
            presentingViewController: sut)
        
        XCTAssertEqual(alertVerifer.preferredAction?.title, "Ok", "preferred action")
    }
}
