//
//  ViewControllerTests.swift
//  NetworkResponseTests
//
//  Created by Ayemere  Odia  on 2022/11/28.
//

import XCTest
@testable import NetworkResponse
import ViewControllerPresentationSpy

class ViewControllerTests: XCTestCase {
    private var alertVerifier: AlertVerifier!
    private var sut: ViewController!
    private var spyURLSession: SpyURLSession!
    
    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            XCTFail("ViewController not available")
            return
        }
        
        self.sut = sut
        spyURLSession = SpyURLSession()
    }
    
    override func tearDown() {
        sut = nil
        alertVerifier = nil
        spyURLSession = nil
        super.tearDown()
    }

    func test_searchForBookNetworkCall_withSuccessResponse_shouldSaveDataInResults() {
        sut.session = spyURLSession
        sut.loadViewIfNeeded()
        tap(sut.button)
        
        let handleResultsCalled = expectation(description: "handle results called")
        
        sut.handleResults = { _ in
            handleResultsCalled.fulfill()
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.01)
        
        XCTAssertEqual(sut.results, [SearchResult(artistName: "Artist", trackName: "Track", averageUserRating: 2.5, description: "Description", genres: ["Foo", "Bar"])])
    }
    
    func test_searchFor_BookNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInResults() {
        
        sut.session = spyURLSession
        sut.loadViewIfNeeded()
        tap(sut.button)
        
        let handleResultsCalled = expectation(description: "handle results called")
        
        sut.handleResults = { _ in
            handleResultsCalled.fulfill()
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.01)
        
        XCTAssertEqual(sut.results, [])
    }
    
    func test_searchForBookNetworkCall_withError_shouldShowAlert() {
        sut.session = spyURLSession
        sut.loadViewIfNeeded()
        tap(sut.button)
        let alertShown = expectation(description: "alert shown")
        alertVerifier.testCompletion = {
            alertShown.fulfill()
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?( nil, nil, TestError(message: "oh no")
        )
        
        waitForExpectations(timeout: 0.01)
        
        verifyErrorAlert(message: "oh no")
        
    }
    
    func test_searchForBookNetworkCall_withErrorPreAsync_shouldNotShowAlert() {
        sut.session = spyURLSession
        sut.loadViewIfNeeded()
        tap(sut.button)
        spyURLSession.dataTaskArgsCompletionHandler.first?( nil, nil, TestError(message: "DUMMY")
        )
        XCTAssertEqual(alertVerifier.presentedCount, 0)
    }
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "http://DUMMY")!,statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }

    private func jsonData() -> Data {
        """
        {
            "results" :
            [
                {
                    "artistName" : "Artist",
                    "trackName" : "Track",
                    "averageUserRating" : 2.5,
                    "description" : "Description",
                    "genres" : [
                                "Foo",
                                "Bar"
                                ]
                }
            ]
        }
        """.data(using: .utf8)!
    }
    
    private func verifyErrorAlert(message: String, file: StaticString = #file, line: UInt = #line) {
        alertVerifier.verify(
            title: "Network problem",
            message: message, animated: true, actions: [
                .default("OK"), ],
            presentingViewController: sut,
            file: file,
            line: line
        )
        
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action", file: file, line: line)
    }
}
