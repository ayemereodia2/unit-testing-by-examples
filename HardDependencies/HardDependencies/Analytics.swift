//
//  Analytics.swift
//  HardDependencies
//
//  Created by Ayemere  Odia  on 2022/11/17.
//

import Foundation

class Analytics {
    static let shared = Analytics()
    
    func track(event: String) {
        print(">>>> + \(event)")
        
        if  self !== Analytics.shared {
            print(">>>>> Not the analytic singleton")
        }
    }
}
