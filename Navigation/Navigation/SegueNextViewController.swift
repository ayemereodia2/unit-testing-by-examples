//
//  SegueNextViewController.swift
//  Navigation
//
//  Created by Ayemere  Odia  on 2022/11/24.
//

import UIKit

class SegueNextViewController: UIViewController {

    var labelText: String?
    
    @IBOutlet private(set) var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelText
    }
    
    deinit {
        print(">> SegueNextViewController.deinit")
    }
}
