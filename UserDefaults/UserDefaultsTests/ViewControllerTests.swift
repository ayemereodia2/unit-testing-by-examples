//
//  ViewControllerTests.swift
//  UserDefaultsTests
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import XCTest
@testable import UserDefaults

class ViewControllerTests: XCTestCase {
    private var fakeUserDefault : FakeUserDefaults!
    private var sut : ViewController!

    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let sut = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            XCTFail("ViewController not in storyboard")
            return
        }
        self.sut = sut
        fakeUserDefault = FakeUserDefaults()
    }
    
    override func tearDown() {
        sut = nil
        fakeUserDefault = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_withEmptyUserDefaults_shouldShow0InCounterLabel() {
        
        sut.userDefaults = fakeUserDefault
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.counterLabel.text, "0")
        
    }

    func test_viewDidLoad_with7InUserDefaults_shouldShow7InCounterLabel() { fakeUserDefault.integers = ["count": 7]
        sut.userDefaults = fakeUserDefault
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.counterLabel.text, "7")
    }
    
    func test_tappingButton_with12InUserDefaults_shouldWrite13ToUserDefaults() { fakeUserDefault.integers = ["count": 12]
        sut.userDefaults = fakeUserDefault
        sut.loadViewIfNeeded()
        tap(sut.incrementButton)
        XCTAssertEqual(fakeUserDefault.integers["count"], 13)
    }
    
    func test_tappingButton_with42InUserDefaults_shouldShow43InCounterLabel() { fakeUserDefault.integers = ["count": 42]
        sut.userDefaults = fakeUserDefault
        sut.loadViewIfNeeded()
        tap(sut.incrementButton)
        XCTAssertEqual(sut.counterLabel.text, "43")
    }
}
