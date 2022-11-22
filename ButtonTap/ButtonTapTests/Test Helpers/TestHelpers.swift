//
//  TestHelpers.swift
//  ButtonTapTests
//
//  Created by Ayemere  Odia  on 2022/11/22.
//

import Foundation
import UIKit

func tap(_ button : UIButton) {
    button.sendActions(for: .touchUpInside)
}
