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
    private lazy var presenter = ChangePasswordPresenter(view: self, viewModel: viewModel)
    
    func setCancelButtonEnabled(_ enabled: Bool) {
        cancelBarButton.isEnabled = enabled
    }
    
    func setCancelButtonEnabled(_ oldValue: ChangePasswordViewModel?) {
        setCancelButtonEnabled(oldValue)
    }
    
    var viewModel: ChangePasswordViewModel!
    
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
        updateInputFocus(.noKeyBoard)
        dismissModal()
    }
    
    @IBAction private func changePassword() {
        updateViewModelToTextFields()
        guard validateInputs() else {
            return
        }
        
        setUpWaitingAppearance()
        attemptToChangePassword()
    }
    
    
    
    private func validateInputs() -> Bool {
        
        if viewModel.isOldPasswordEmpty {
            updateInputFocus(.oldPassword)
            return false
        }
        
        if viewModel.isNewPasswordEmpty {
            showAlert(message: viewModel.enterNewPasswordMessage, okAction: { [weak self] _ in
                self?.updateInputFocus(.newPassword)
            })
            
            return false
        }
        
        if viewModel.isNewPasswordTooShort {            
            showAlert(message: viewModel.newPasswordTooShortMessage, okAction: { [weak self] _ in
                self?.resetNewPasswords()
                self?.updateInputFocus(.newPassword)
            })
            return false
        }
        
        if newPasswordTextField.text != confirmPasswordTextField.text {
            showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage, okAction: { [weak self] _ in
                self?.resetNewPasswords()
                self?.updateInputFocus(.newPassword)
            })
            return false
        }
        
        return true
    }
    
    
    
    private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(
            title: nil,
            message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: viewModel.okButtonLabel, style: .default, handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
    
    private func setUpWaitingAppearance() {
        updateInputFocus(.noKeyBoard)
        setCancelButtonEnabled(false)
        showBlurView()
        showActivityIndicator()
    }
    
    private func attemptToChangePassword() {
        passwordChanger.change(
            securityToken: securityToken,
            oldPassword: viewModel.oldPassword,
            newPassword: viewModel.newPassword,
            onSuccess: { [weak self] in
                self?.presenter.handleSuccess()
            }, onFailure: { [weak self] message in
                self?.handleFailure(message: message)
            })
    }
    
    private func handleFailure(message: String) {
        hideActivityIndicator()
        showAlert(message: message) { [weak self] in
            self?.oldPasswordTextField.text = ""
            self?.newPasswordTextField.text = ""
            self?.confirmPasswordTextField.text = ""
            self?.updateInputFocus(.oldPassword)
            self?.hideBlurView()
            self?.setCancelButtonEnabled(true)
        }
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
        navigationBar.topItem?.title = viewModel.title
        oldPasswordTextField.placeholder = viewModel.oldPasswordPlaceholder
        newPasswordTextField.placeholder = viewModel.newPasswordPlaceholder
        confirmPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
        submitButton.setTitle(viewModel.submitButtonLabel, for: .normal)
    }
}

extension ChangePasswordViewController {
    func updateInputFocus(_ inputFocus: ChangePasswordViewModel.InputFocus) {
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
    
    private func updateViewModelToTextFields() {
        viewModel.oldPassword = oldPasswordTextField.text ?? ""
        viewModel.newPassword = newPasswordTextField.text ?? ""
        viewModel.confirmPassword = confirmPasswordTextField.text ?? ""
    }

    private func resetNewPasswords() {
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
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
}
