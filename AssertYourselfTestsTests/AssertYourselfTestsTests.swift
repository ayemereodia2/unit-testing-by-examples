//
//  AssertYourselfTestsTests.swift
//  AssertYourselfTestsTests
//
//  Created by Ayemere  Odia  on 2022/11/11.
//

import XCTest
@testable import AssertYourselfTests

class AssertYourselfTestsTests: XCTestCase {
    
    func test_fail() {
        //XCTFail("We have a problem here!")
    }
    
    func test_assertnil() {
        let optionalValue : Int? =  123
        XCTAssertNil(optionalValue)
    }
    
    func test_assertNil_WithSimpleStruct() {
        let optionalValue : SimpleStruct? =  SimpleStruct(x: 1, y: 2)
        XCTAssertNil(optionalValue)
    }
    
    func test_assert_equal() {
        let actual = "actual"
        XCTAssertEqual(actual, "expected")
    }
    
    func test_assert_equal_withOptional() {
        let result: String? = "foo"
        XCTAssertEqual(result, "bar")
    }
    
    func test_floatingPointDanger() {
        let result = 0.1 + 0.2
        XCTAssertEqual(result, 0.3, accuracy: 0.0001)
    }
    
    func test_messageOverKill() {
        let actual = "actual"
        XCTAssertEqual(actual, "expected", "Expected \"expected\" but got \"\(actual)\"")
    }
}

struct SimpleStruct: CustomStringConvertible {
    let x: Int
    let y: Int
    
    var description: String {
        "\(x) \(y)"
    }
}
