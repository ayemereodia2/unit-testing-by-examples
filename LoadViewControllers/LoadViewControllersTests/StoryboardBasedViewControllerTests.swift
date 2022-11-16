//
//  StoryboardBasedViewControllerTests.swift
//  LoadViewControllersTests
//
//  Created by Ayemere  Odia  on 2022/11/16.
//

import XCTest
@testable import LoadViewControllers

class StoryboardBasedViewControllerTests: XCTestCase {

    func test_loading() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sut = storyboard.instantiateViewController(withIdentifier: String(describing: StoryboardBasedViewController.self)) as? StoryboardBasedViewController else {
            XCTFail("Error loading viewcontroller")
            return
        }
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.label)
    }
    
    func test_xib_loading() {
        let sut = XIBBasedViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label)
    }
    
    func test_code_loading() {
        let sut = CodeBasedViewController(data: "YAYAYA")
        sut.loadViewIfNeeded()
    }
}
