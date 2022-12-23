//
//  PasswordInputs.swift
//  Refactoring
//
//  Created by Ayemere  Odia  on 2022/12/23.
//

import Foundation

struct PasswordInputs {
    var oldPassword: String
    var newPassword: String
    var confirmPassword: String
    
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
