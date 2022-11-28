//
//  TestError.swift
//  NetworkResponseTests
//
//  Created by Ayemere  Odia  on 2022/11/28.
//

import Foundation

struct TestError : LocalizedError {
    let message: String
    var errorDescription: String? { message }
}
