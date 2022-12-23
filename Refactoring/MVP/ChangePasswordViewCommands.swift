//
//  ChangePasswordViewCommands.swift
//  Refactoring
//
//  Created by Ayemere  Odia  on 2022/12/16.
//

import Foundation
protocol ChangePasswordViewCommands: AnyObject {
    func hideActivityIndicator()
    func showActivityIndicator()
    func dismissModal()
    func showAlert(message: String, action: @escaping () -> Void)
    func hideBlurView()
    func showBlurView()
    func updateInputFocus(_ inputFocus: InputFocus)
    func setCancelButtonEnabled(_ enabled: Bool)
    func startOver()
    func resetNewPasswords()
}

enum InputFocus {
    case noKeyBoard
    case oldPassword
    case newPassword
    case confirmPassword
}
