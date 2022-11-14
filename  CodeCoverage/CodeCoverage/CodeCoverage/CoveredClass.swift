//
//  CoveredClass.swift
//  CodeCoverage
//
//  Created by Ayemere  Odia  on 2022/11/14.
//

import UIKit

class CoveredClass {
    private(set) var area: Int
    
    var width: Int {
        didSet {
            area = width * width
            let color = redOrGreen(for: width)
            drawSquare(width: width, color: color)
        }
    }
    
    init() {
     area = 0
     width = 0
    }
    
    private func redOrGreen(for width: Int) -> UIColor {
        width % 2 == 0 ? .red : .green
    }
    
    private func drawSquare(width: Int, color: UIColor) {
        
    }
    static func max(_ x: Int, _ y: Int) -> Int {
        if x < y {
            return y
        } else {
            return x
        }
    }
    
    static func commaSeparated(_ from: Int, _ to: Int) -> String {
        var result = ""
        
        for i in from..<to {
            result += "\(i),"
        }
        result += "\(to)"
        return result
    }
}
