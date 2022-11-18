//
//  InstancePropertyViewController.swift
//  HardDependencies
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import UIKit

class InstancePropertyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        Analytics.shared.track(event: "viewDidAppear - \(type(of: self))")
    }
}
