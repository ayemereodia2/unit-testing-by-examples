//
//  ChangePasswordPresenter.swift
//  Refactoring
//
//  Created by Ayemere  Odia  on 2022/12/16.
//

import Foundation

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!
    private let viewModel: ChangePasswordLabels
    private var securityToken: String, passwordChanger: PasswordChanging
    
    init(view: ChangePasswordViewCommands,
         viewModel: ChangePasswordLabels,
         securityToken: String, passwordChanger: PasswordChanging) {
        self.view = view
        self.viewModel = viewModel
        self.securityToken = securityToken
        self.passwordChanger = passwordChanger
    }
    
    func handleSuccess() {
        view.hideActivityIndicator()
        view.showAlert(message: viewModel.successMessage){ [weak self] in
            self?.view.dismissModal()
        }
    }
    
    func handleFailure(message: String) {
        view.hideActivityIndicator()
        view.showAlert(message: message) { [weak self] in
            self?.view.startOver()
        }
    }
    
    func attemptToChangePassword(passwordInputs: PasswordInputs) {
        passwordChanger.change(
            securityToken: securityToken,
            oldPassword: passwordInputs.oldPassword,
            newPassword: passwordInputs.newPassword,
            onSuccess: { [weak self] in
                self?.handleSuccess()
            }, onFailure: { [weak self] message in
                self?.handleFailure(message: message)
            })
    }
    
    func resetNewPasswords() {
        view.resetNewPasswords()
    }
    
    func validateInputs(passwordInputs: PasswordInputs) -> Bool {
        
        if passwordInputs.isOldPasswordEmpty {
            view.updateInputFocus(.oldPassword)
            return false
        }
        
        if passwordInputs.isNewPasswordEmpty {
            view.showAlert(message: viewModel.enterNewPasswordMessage, action: { [weak self] in
                self?.view.updateInputFocus(.newPassword)
            })
            
            return false
        }
        
        if passwordInputs.isNewPasswordTooShort {
            view.showAlert(message: viewModel.newPasswordTooShortMessage, action: { [weak self]  in
                self?.resetNewPasswords()
                self?.view.updateInputFocus(.newPassword)
            })
            return false
        }
        
        if !passwordInputs.isConfirmPasswordMismatched {
            view.showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage, action: { [weak self] in
                self?.resetNewPasswords()
                self?.view.updateInputFocus(.newPassword)
            })
            return false
        }
        
        return true
    }
    
    func cancel() {
        view.updateInputFocus(.noKeyBoard)
        view.dismissModal()
    }
    
    func setUpWaitingAppearance() {
        view.updateInputFocus(.noKeyBoard)
        view.setCancelButtonEnabled(false)
        view.showBlurView()
        view.showActivityIndicator()
    }
}
