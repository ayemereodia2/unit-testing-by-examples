//
//  ChangePasswordViewController.swift
//  Refactoring
//
//  Created by Ayemere  Odia  on 2022/12/06.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet private(set) var cancelBarButton: UIBarButtonItem!
    @IBOutlet private(set) var oldPasswordTextField: UITextField!
    @IBOutlet private(set) var newPasswordTextField: UITextField!
    @IBOutlet private(set) var confirmPasswordTextField: UITextField!
    @IBOutlet private(set) var submitButton: UIButton!
    @IBOutlet private(set) var navigationBar: UINavigationBar!
    lazy var passwordChanger:PasswordChanging = PasswordChanger()
    
    var securityToken = ""
     let blurView = UIVisualEffectView(effect:UIBlurEffect(style: .dark))
     let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
    }
    
    
    @IBAction private func cancel() {
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @IBAction private func changePassword() {        
        guard validateInputs() else {
            return
        }
        
        setUpWaitingAppearance()
        activityIndicator.startAnimating()
        attemptToChangePassword()
    }
    
    
    
    private func validateInputs() -> Bool {
        
        if oldPasswordTextField.text?.isEmpty ?? true {
            oldPasswordTextField.becomeFirstResponder()
            return false
        }
        
        if newPasswordTextField.text?.isEmpty ?? true {
            showAlert(message: "Please enter a new password.", okAction: { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            })
            
            return false
        }
        
        if newPasswordTextField.text?.count ?? 0 < 6 {            
            showAlert(message: "The new password should have at least 6 characters.", okAction: { [weak self] _ in
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.newPasswordTextField.becomeFirstResponder()
            })
            return false
        }
        
        if newPasswordTextField.text != confirmPasswordTextField.text {
            showAlert(message: "The new password and the confirmation password " + "don’t match. Please try again.", okAction: { [weak self] _ in
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.newPasswordTextField.becomeFirstResponder()
            })
            return false
        }
        
        return true
    }
    
    private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(
            title: nil,
            message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
    
    private func setUpWaitingAppearance() {
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        cancelBarButton.isEnabled = false
        view.backgroundColor = .clear
        view.addSubview(blurView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func attemptToChangePassword() {
        passwordChanger.change(
            securityToken: securityToken,
            oldPassword: oldPasswordTextField.text ?? "",
            newPassword: newPasswordTextField.text ?? "",
            onSuccess: { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
                
                let alertController = UIAlertController(
                    title: "",
                    message: "Your password has been successfully changed.",
                    preferredStyle: .alert)
                
                let okButton = UIAlertAction(
                    title: "OK", style:.default) { [weak self] _ in
                        self?.dismiss(animated: true)
                    }
                
                alertController.addAction(okButton)
                alertController.preferredAction = okButton
                
                self?.present(alertController, animated: true)
                
            }, onFailure: { [weak self] message in
                
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
                
                let alertController = UIAlertController(
                    title: "",
                    message: message,
                    preferredStyle: .alert)
                
                let okButton = UIAlertAction( title: "OK",
                                              style: .default) { [weak self] _ in
                    
                    self?.oldPasswordTextField.text = ""
                    self?.newPasswordTextField.text = ""
                    self?.confirmPasswordTextField.text = ""
                    self?.oldPasswordTextField.becomeFirstResponder()
                    self?.view.backgroundColor = .white
                    self?.blurView.removeFromSuperview()
                    self?.cancelBarButton.isEnabled = true
                }
                alertController.addAction(okButton)
                alertController.preferredAction = okButton
                self?.present(alertController, animated: true)
            })
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
        }
        else if textField === newPasswordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField === confirmPasswordTextField {
            changePassword()
        }
        return true
    }
}

