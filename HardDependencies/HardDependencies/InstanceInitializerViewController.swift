//
//  InstanceInitializerViewController.swift
//  HardDependencies
//
//  Created by Ayemere  Odia  on 2022/11/18.
//

import UIKit

class InstanceInitializerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics.track(event: "viewDidAppear - \(type(of: self))")
    }
    
    private let analytics: Analytics
    
    init(analytics: Analytics = Analytics.shared) {
        self.analytics = analytics
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
