//
//  ViewControllerTests.swift
//  NavigationTests
//
//  Created by Ayemere  Odia  on 2022/11/24.
//

import XCTest
@testable import Navigation
import ViewControllerPresentationSpy

class ViewControllerTests: XCTestCase {
    
    private var presentationVerifier: PresentationVerifier!
    private var sut: ViewController?
    
    override func setUp() {
        super.setUp()
        presentationVerifier = PresentationVerifier()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
        presentationVerifier = nil
        sut = nil
        super.tearDown()
    }
    
    func test_tappingCodePushButton_shouldPushCodeNextViewController() {
        
        let navigation = UINavigationController(rootViewController: sut!)
        
        guard let button = sut?.codePushButton else {
            XCTFail("Button does not exist")
            return
            
        }
        
        tap(button)
        
        executeRunLoop()
        
        XCTAssertEqual(navigation.viewControllers.count, 2, "navigation stack")
        
        let pushedVC = navigation.viewControllers.last
        
        guard let codeNextVC = pushedVC as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController, "
                    + "but was \(String(describing: pushedVC))")
            return
        }
        
        XCTAssertEqual(codeNextVC.label.text, "Pushed from code")
    }

    func xtest_INCORRECT_tappingCodeModalButton_shouldPresentCodeNextViewController() {
        
        UIApplication.shared.windows.first?.rootViewController = sut
        
        guard let button = sut?.codeModalButton else {
            XCTFail("Button does not exist")
            return
            
        }
        tap(button)
        
        let presentedVC = sut?.presentedViewController
        
        guard let codeNextVC = presentedVC as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController, "
                    + "but was \(String(describing: presentedVC))")
            return
        }
        
        XCTAssertEqual(codeNextVC.label.text, "Modal from code")
    }
    
    func test_tappingCodeModalButton_shouldPresentCodeNextViewController() {
        sut?.loadViewIfNeeded()
        
        let navigation = UINavigationController(rootViewController: sut!)
        
        guard let button = sut?.codeModalButton else {
            XCTFail("Button does not exist")
            return
            
        }
        tap(button)
        
        let codeNextVC: CodeNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)
        
        XCTAssertEqual(codeNextVC?.label.text, "Modal from code")
    }
    
    func test_tappingSeguePushButton_shouldShowSegueNextViewController() {
    
        putInWindow(sut!)
        guard let button = sut?.seguePushButton else {
            XCTFail("Button does not exist")
            return
            
        }
        
        tap(button)
        
        let segueNextVC: SegueNextViewController? = presentationVerifier.verify( animated: true, presentingViewController: sut)
        XCTAssertEqual(segueNextVC?.labelText, "Pushed from segue")
    }
    
    func test_tappingSegueModalButton_shouldShowSegueNextViewController() {
        putInWindow(sut!)
        guard let button = sut?.segueModalButton else {
            XCTFail("Button does not exist")
            return
            
        }
        
        tap(button)
        let segueNextVC: SegueNextViewController? = presentationVerifier.verify( animated: true, presentingViewController: sut)
        XCTAssertEqual(segueNextVC?.labelText, "Modal from segue")
    }
}
