//
//  ChangePasswordPresenter.swift
//  Refactoring
//
//  Created by Ayemere  Odia  on 2022/12/16.
//

import Foundation

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!
    private var viewModel: ChangePasswordViewModel
    
    init(view: ChangePasswordViewCommands, viewModel: ChangePasswordViewModel) {
        self.view = view
        self.viewModel = viewModel
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
            
        }
    }
}
