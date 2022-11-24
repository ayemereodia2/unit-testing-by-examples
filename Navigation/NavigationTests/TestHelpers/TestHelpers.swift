//
//  TestHelpers.swift
//  NavigationTests
//
//  Created by Ayemere  Odia  on 2022/11/24.
//

import Foundation
import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

func putInWindow(_ vc: UIViewController) {
    let window = UIWindow()
    window.rootViewController = vc
    window.isHidden = false
}
