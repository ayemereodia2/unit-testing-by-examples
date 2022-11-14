//
//  CoveredClassTests.swift
//  CodeCoverageTests
//
//  Created by Ayemere  Odia  on 2022/11/14.
//

import XCTest
@testable import CodeCoverage

class CoveredClassTests: XCTestCase {
    func test_max_with1and2_ShouldReturn2() {
        let result = CoveredClass.max(1, 2)
        XCTAssertEqual(result, 2)
    }
    
    func test_max_with3and2_ShouldReturn3() {
        let result = CoveredClass.max(2, 3)
        XCTAssertEqual(result, 3)
    }
    
    func test_commaSeparated_from2To4_shouldReturn234SeperatedByCommas() {
        let result = CoveredClass.commaSeparated(2, 4)
        XCTAssertEqual(result, "2,3,4")
    }
    
    func test_commaSeparated_from2To2_shouldReturnSomething() {
        let result = CoveredClass.commaSeparated(2, 2)
        XCTAssertEqual(result, "2")
    }
    
    func test_area_withWidth7ReturnsSomething() {
        let sut = CoveredClass()
        sut.width = 7
        XCTAssertEqual(sut.area, -1)
    }
}
