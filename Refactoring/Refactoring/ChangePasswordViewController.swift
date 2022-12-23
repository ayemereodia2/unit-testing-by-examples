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
    private lazy var presenter = ChangePasswordPresenter(
        view: self,
        label: label,
        securityToken: "TOKEN",
        passwordChanger: passwordChanger)
    
    func setCancelButtonEnabled(_ enabled: Bool) {
        cancelBarButton.isEnabled = enabled
    }
    
    func setCancelButtonEnabled(_ oldValue: ChangePasswordLabels?) {
        setCancelButtonEnabled(oldValue)
    }
    
    var label: ChangePasswordLabels!
    
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
        presenter.cancel()
    }
    
    @IBAction private func changePassword() {
        let passwordInputs = PasswordInputs(
        oldPassword: oldPasswordTextField.text ?? "",
        newPassword: newPasswordTextField.text ?? "",
        confirmPassword: confirmPasswordTextField.text ?? "")
        changePassword(passwordInputs: passwordInputs)
    }
    
    func changePassword(passwordInputs: PasswordInputs) {
        guard presenter.validateInputs(passwordInputs: passwordInputs) else {
            return
        }
        
        presenter.setUpWaitingAppearance()
        presenter.attemptToChangePassword(passwordInputs: passwordInputs)
    }
    
    private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(
            title: nil,
            message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: label.okButtonLabel, style: .default, handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
    
    private func handleFailure(message: String) {
        presenter.handleFailure(message: message)
    }
    
    func startOver() {
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        updateInputFocus(.oldPassword)
        hideBlurView()
        setCancelButtonEnabled(true)
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            updateInputFocus(.newPassword)
        }
        else if textField === newPasswordTextField {
            updateInputFocus(.confirmPassword)
        } else if textField === confirmPasswordTextField {
            changePassword()
        }
        return true
    }
}

extension ChangePasswordViewController {
    private func setLabels() {
        navigationBar.topItem?.title = label.title
        oldPasswordTextField.placeholder = label.oldPasswordPlaceholder
        newPasswordTextField.placeholder = label.newPasswordPlaceholder
        confirmPasswordTextField.placeholder = label.confirmPasswordPlaceholder
        submitButton.setTitle(label.submitButtonLabel, for: .normal)
    }
}

extension ChangePasswordViewController {
    func updateInputFocus(_ inputFocus: InputFocus) {
        switch inputFocus {
        case .noKeyBoard:
            view.endEditing(true)
        case .oldPassword:
            oldPasswordTextField.becomeFirstResponder()
        case .newPassword:
            newPasswordTextField.becomeFirstResponder()
        case .confirmPassword:
            confirmPasswordTextField.becomeFirstResponder()
        }
    }
}
extension ChangePasswordViewController: ChangePasswordViewCommands {
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    
    func showActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissModal() {
        dismiss(animated: true)
    }
    
    func showAlert(message: String, action: @escaping () -> Void) {
        let wrappedAction: (UIAlertAction) -> Void = { _ in action() }
        showAlert(message: message, okAction: wrappedAction)
    }
    
    func hideBlurView() {
        blurView.removeFromSuperview()
        view.backgroundColor = .white
    }
    
    func showBlurView() {
        view.backgroundColor = .clear
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func resetNewPasswords() {
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}
