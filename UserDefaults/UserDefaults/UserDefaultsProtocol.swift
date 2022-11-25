//
//  UserDefaultProtocol.swift
//  UserDefaults
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import Foundation
protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey defaultName: String)
    func integer(forKey defaultName: String) -> Int
}

extension UserDefaults : UserDefaultsProtocol {}
