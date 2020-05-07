//
//  Position.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 07/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import UIKit

struct Position {
    let x, y: Int

    init(_ translation: CGSize) {
        x = Int((translation.width / (UIScreen.main.bounds.width / 8)).rounded())
        y = Int((translation.height / (UIScreen.main.bounds.width / 8)).rounded())
    }

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    var size: CGSize {
        CGSize(width: CGFloat(x) * UIScreen.main.bounds.width / 8, height: -CGFloat(y) * UIScreen.main.bounds.width / 8)
    }
}

func +(lhs: Position, rhs: Position) -> Position {
    return Position(x: lhs.x + rhs.x, y: lhs.y - rhs.y)
}
