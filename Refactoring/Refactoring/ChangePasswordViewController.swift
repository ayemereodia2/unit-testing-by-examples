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
    
    func setCancelButtonEnabled(_ oldValue: ChangePasswordViewModel?) {
        if oldValue?.isCancelButtonEnabled != viewModel.isCancelButtonEnabled {
            cancelBarButton.isEnabled = viewModel.isCancelButtonEnabled
        }
    }
    
    var viewModel: ChangePasswordViewModel! {
        didSet {
            guard isViewLoaded else { return }
            
            setCancelButtonEnabled(oldValue)
            
            if oldValue.inputFocus != viewModel.inputFocus {
                updateInputFocus()
            }
            
            if oldValue.isBlurViewShowing != viewModel.isBlurViewShowing {
                updateBlurView()
            }
        }
    }
    
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
        viewModel.inputFocus = .noKeyBoard
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
            viewModel.inputFocus = .oldPassword
            return false
        }
        
        if viewModel.isNewPasswordEmpty {
            showAlert(message: viewModel.enterNewPasswordMessage, okAction: { [weak self] _ in
                self?.viewModel.inputFocus = .newPassword
            })
            
            return false
        }
        
        if viewModel.isNewPasswordTooShort {            
            showAlert(message: viewModel.newPasswordTooShortMessage, okAction: { [weak self] _ in
                self?.resetNewPasswords()
                self?.viewModel.inputFocus = .newPassword
            })
            return false
        }
        
        if newPasswordTextField.text != confirmPasswordTextField.text {
            showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage, okAction: { [weak self] _ in
                self?.resetNewPasswords()
                self?.viewModel.inputFocus = .newPassword
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
        viewModel.inputFocus = .noKeyBoard
        viewModel.isCancelButtonEnabled = false
        viewModel.isBlurViewShowing = true
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
            self?.viewModel.inputFocus = .oldPassword
            self?.viewModel.isBlurViewShowing = false
            self?.viewModel.isCancelButtonEnabled = true
        }
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            viewModel.inputFocus = .newPassword
        }
        else if textField === newPasswordTextField {
            viewModel.inputFocus = .confirmPassword
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
    private func updateInputFocus() {
        switch viewModel.inputFocus {
            
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
    
    private func updateBlurView() {
        if viewModel.isBlurViewShowing {
            view.backgroundColor = .clear
            view.addSubview(blurView)
            NSLayoutConstraint.activate([
                blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
                blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        } else {
            blurView.removeFromSuperview()
            view.backgroundColor = .white
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
        
    }
    
    func showBlurView() {
        
    }
}
