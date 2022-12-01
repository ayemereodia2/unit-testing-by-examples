//
//  TableViewControllerTests.swift
//  TableViewTests
//
//  Created by Ayemere  Odia  on 2022/12/01.
//

import XCTest
@testable import TableView

class TableViewControllerTests: XCTestCase {
    
    private var sut: SampleTableViewController!
    
    override func setUp() { super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
            identifier: String(describing: SampleTableViewController.self))
        sut.loadViewIfNeeded()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_tableViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
    }
    
    func test_numberOfRows_shouldBe3() {
        XCTAssertEqual(numberOfRows(in: sut.tableView, section: 0), 3)
    }
    
    func test_cellForRowAt_withRow0_shouldSetCellLabelToOne() {
        let cell = tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "One")
    }
    
    func test_cellForRowAt_withRow1_shouldSetCellLabelToTwo() {
        let cell = tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "Two")
    }
    
    func test_didSelectRow_withRow1() {
        tableView(sut.tableView, didSelectRowAt: IndexPath(row: 1,section: 0))
    }
}
