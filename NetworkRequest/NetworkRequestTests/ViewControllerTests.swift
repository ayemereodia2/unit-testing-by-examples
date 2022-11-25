//
//  ViewControllerTests.swift
//  NetworkRequestTests
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import XCTest
@testable import NetworkRequest

class ViewControllerTests: XCTestCase {

    func test_tappingButton_shouldMakeDataTaskToSearchForEBookOutFromBoneville() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let sut = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            XCTFail("ViewController does not exist in storyboard")
            return
        }
        
        let mockUrlSession = MockURLSession()
        sut.session = mockUrlSession
        sut.loadViewIfNeeded()
        tap(sut.button)
        
        XCTAssertEqual(mockUrlSession.dataTaskCallCount, 1, "call count")
        XCTAssertEqual( mockUrlSession.dataTaskArgsRequest.first, URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=out%20from%20boneville")!), "request")
    }

}
