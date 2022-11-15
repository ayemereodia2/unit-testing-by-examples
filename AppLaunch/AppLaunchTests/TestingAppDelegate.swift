//
//  TestingAppDelegate.swift
//  AppLaunchTests
//
//  Created by Ayemere  Odia  on 2022/11/15.
//

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: NSObject {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(">>>>>>> Launching App with testing AppDelegate")
        return true
    }
    
    /*
     Setting up core data with an in-memory store. This will keep production data from interfering with test data and vice-versa. It will also help tests to run faster.
     */
    
    /*
     Providing a testing-specific key for an analytics service. Unit tests shouldn’t make any actual network calls, but they’ll still happen until you change the legacy code. So at the very least, use a different key to avoid polluting the data you collect
     */
}
