//
//  OutletConnectionsViewControllerTests.swift
//  OutletConnectionTests
//
//  Created by Ayemere  Odia  on 2022/11/22.
//

import XCTest
@testable import OutletConnection

class OutletConnectionsViewControllerTests: XCTestCase {

    func test_outlet_ShouldBe_Connected() {
        let sut = OutletConnectionsViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label, "label")
        XCTAssertNotNil(sut.button, "button")
    }
}
