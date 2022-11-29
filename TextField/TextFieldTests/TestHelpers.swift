//
//  TestHelpers.swift
//  TextFieldTests
//
//  Created by Ayemere  Odia  on 2022/11/29.
//

import UIKit

extension UITextContentType : CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension UITextAutocorrectionType : CustomStringConvertible {
    public var description: String {
        switch self {
        case .default :
            return "default"
        case .no :
            return "no"
        case .yes :
            return "yes"
        @unknown default:
            fatalError("Unknown UITextAutocorrectionType")
        }
    }
}

extension UIReturnKeyType : CustomStringConvertible {
    public var description: String {
        switch self {
        case .default :
            return "default"
        case .continue:
            return "continue"
        case .done :
            return "done"
        case .emergencyCall:
            return "emergencyCall"
        case .go :
            return "go"
        case .google :
            return "google"
        case .next :
            return "next"
        case .route :
            return "route"
        case .yahoo :
            return "yahoo"
        case .send :
            return "send"
        case .search:
            return "search"
        case .join:
            return "join"
        @unknown default:
            fatalError("case does not exist")
        }
    }
}

func shouldChangeCharacters(in textField: UITextField, range: NSRange = NSRange(),
                            replacement: String) -> Bool? {
    textField.delegate?.textField?(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: replacement)
}

@discardableResult func shouldReturn(in textField: UITextField) -> Bool? { textField.delegate?.textFieldShouldReturn?(textField)
}

func putInViewHierarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}


func executeRunLoop() {
    RunLoop.current.run(until: Date())
}
