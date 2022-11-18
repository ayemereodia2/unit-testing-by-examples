//
//  InstanceInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import XCTest
@testable import HardDependencies

class InstanceInitializerViewControllerTests: XCTestCase {
    
    func test_viewDidAppear() {
        let sut = InstanceInitializerViewController(analytics: Analytics())
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
