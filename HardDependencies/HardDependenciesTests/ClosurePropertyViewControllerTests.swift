//
//  ClosurePropertyViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import XCTest
@testable import HardDependencies

class ClosurePropertyViewControllerTests: XCTestCase {
    
    func test_viewDidAppear() {
        let sut = ClosurePropertyViewController { Analytics() }
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }

}
