//
//  ChangePasswordViewModel.swift
//  Refactoring
//
//  Created by Ayemere  Odia  on 2022/12/15.
//

import Foundation

struct ChangePasswordViewModel {
    let okButtonLabel: String
    let enterNewPasswordMessage: String
    let newPasswordTooShortMessage: String
    let confirmationPasswordDoesNotMatchMessage: String
    let successMessage: String
    let title: String = "Change Password"
    let oldPasswordPlaceholder: String = "Current Password"
    let newPasswordPlaceholder: String = "New Password"
    let confirmPasswordPlaceholder: String = "Confirm New Password"
    let submitButtonLabel: String = "Submit"        
    enum InputFocus {
        case noKeyBoard
        case oldPassword
        case newPassword
        case confirmPassword
    }
        
    var oldPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    
    var isOldPasswordEmpty: Bool {
        oldPassword.isEmpty
    }
    
    var isNewPasswordEmpty: Bool {
        newPassword.isEmpty
    }
    
    var isNewPasswordTooShort: Bool {
        newPassword.count < 6 ? true : false
    }
    
    var isConfirmPasswordMismatched: Bool {
        newPassword == confirmPassword ? true : false
    }
}
