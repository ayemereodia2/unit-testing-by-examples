//
//  URLSessionProtocol.swift
//  NetworkRequest
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask( with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask
}

extension URLSession : URLSessionProtocol {
    
}
