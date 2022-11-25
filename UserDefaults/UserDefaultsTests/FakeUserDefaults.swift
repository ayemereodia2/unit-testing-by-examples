//
//  FakeUserDefaults.swift
//  UserDefaultsTests
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import Foundation
@testable import UserDefaults

class FakeUserDefaults: UserDefaultsProtocol {
    var integers:[String:Int] = [:]
    func set(_ value: Int, forKey defaultName: String) {
        integers[defaultName] = value
    }
    
    func integer(forKey defaultName: String) -> Int {
        self.integers[defaultName] ?? 0
    }
}
