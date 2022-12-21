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
}
