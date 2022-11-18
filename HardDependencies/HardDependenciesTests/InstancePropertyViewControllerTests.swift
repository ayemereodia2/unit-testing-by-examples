//
//  InstancePropertyViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import XCTest
@testable import HardDependencies

class InstancePropertyViewControllerTests: XCTestCase {

    func test_viewDidLoad() {
        let sut = InstancePropertyViewController()
        sut.analytics = Analytics()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }

}
