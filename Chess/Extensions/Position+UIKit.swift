//
//  Position+UIKit.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 12/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

extension Position {
    var size: CGSize {
        CGSize(width: CGFloat(x) * UIScreen.main.bounds.width / 8, height: -CGFloat(y) * UIScreen.main.bounds.width / 8)
    }

    init(_ translation: CGSize) {
        x = Int((translation.width / (UIScreen.main.bounds.width / 8)).rounded())
        y = Int((translation.height / (UIScreen.main.bounds.width / 8)).rounded())
    }
}
