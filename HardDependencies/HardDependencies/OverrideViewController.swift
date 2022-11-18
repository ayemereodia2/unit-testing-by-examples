//
//  OverrideViewController.swift
//  HardDependencies
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import UIKit

class OverrideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   func analytics() -> Analytics { Analytics.shared }
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        analytics().track(event: "viewDidAppear - \(type(of: self))")
    }
}
