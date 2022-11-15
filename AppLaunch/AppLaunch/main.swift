//
//  main.swift
//  AppLaunch
//
//  Created by Ayemere  Odia  on 2022/11/15.
//

import UIKit
let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc,CommandLine.unsafeArgv, nil,NSStringFromClass(appDelegateClass))
