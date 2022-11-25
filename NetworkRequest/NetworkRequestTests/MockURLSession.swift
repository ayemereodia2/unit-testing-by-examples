//
//  MockURLSession.swift
//  NetworkRequestTests
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import Foundation
@testable import NetworkRequest

class MockURLSession : URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return DummyURLSessionDataTask()
    }
}

private class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}
