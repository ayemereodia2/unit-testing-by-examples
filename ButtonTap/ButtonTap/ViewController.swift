//
//  ViewController.swift
//  ButtonTap
//
//  Created by Ayemere  Odia  on 2022/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTap(_ sender: Any) {
        print(">>>> Button was Tapped")
    }
    
}

