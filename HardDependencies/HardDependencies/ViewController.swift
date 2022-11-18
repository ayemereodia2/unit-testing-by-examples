//
//  ViewController.swift
//  HardDependencies
//
//  Created by Ayemere  Odia  on 2022/11/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        Analytics.shared.track(event: "viewDidAppear - \(type(of: self))")
    }

}

