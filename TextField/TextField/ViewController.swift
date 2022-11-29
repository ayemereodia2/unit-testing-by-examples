//
//  ViewController.swift
//  TextField
//
//  Created by Ayemere  Odia  on 2022/11/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var usernameField: UITextField!
    @IBOutlet private(set) var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    deinit {
        print("ViewController.deinit")
    }
}


extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === usernameField {
            return !string.contains(" ")
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameField {
            passwordField.becomeFirstResponder()
        } else {
            guard let username = usernameField.text,
                  let password = passwordField.text else {
                      return false
                  }
            
            passwordField.resignFirstResponder()
            performLogin(username: username, password: password)
        }
        return false
    }
    
    private func performLogin(username: String, password: String) {
        print("username:| \(username)")
        print("password:| \(password)")
    }
}
