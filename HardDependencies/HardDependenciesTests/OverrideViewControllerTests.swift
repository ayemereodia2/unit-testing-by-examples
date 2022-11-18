//
//  OverrideViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import XCTest
@testable import HardDependencies

class OverrideViewControllerTests: XCTestCase {
    
    func test_viewDidAppear() {
        let sut = TestableOverrideViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }

}

private class TestableOverrideViewController: OverrideViewController {
    override func analytics() -> Analytics {
        Analytics()
    }
}
