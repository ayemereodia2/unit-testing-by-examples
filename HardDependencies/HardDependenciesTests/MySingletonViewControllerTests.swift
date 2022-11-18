//
//  MySingletonViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import XCTest
@testable import HardDependencies

class MySingletonViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        MySingletonAnalytics.stubbedInstance = MySingletonAnalytics()
    }

    override class func tearDown() {
        MySingletonAnalytics.stubbedInstance = nil
        super.tearDown()
    }
    
    func test_viewDidAppear() {
        let sut = MySingletonViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
