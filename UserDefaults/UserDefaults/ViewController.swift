//
//  ViewController.swift
//  UserDefaults
//
//  Created by Ayemere  Odia  on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var counterLabel: UILabel!
    @IBOutlet private(set) var incrementButton: UIButton!
    var userDefaults:UserDefaultsProtocol = UserDefaults.standard
    private var count = 0 {
        didSet {
            counterLabel.text = "\(count)"
            userDefaults.set(count, forKey: "count")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        count = userDefaults.integer(forKey: "count")
    }
    
    @IBAction private func incrementButtonTapped() {
        count += 1
    }
}

