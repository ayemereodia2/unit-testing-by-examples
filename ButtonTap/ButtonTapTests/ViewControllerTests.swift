//
//  ViewControllerTests.swift
//  ButtonTapTests
//
//  Created by Ayemere  Odia  on 2022/11/22.
//

import XCTest
@testable import ButtonTap

class ViewControllerTests: XCTestCase {

    func test_TappingButton() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyBoard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        sut.loadViewIfNeeded()
        tap(sut.button)
    }

}
