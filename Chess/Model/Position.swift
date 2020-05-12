//
//  Position.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 07/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Position {
    let x, y: Int
}

func +(lhs: Position, rhs: Position) -> Position {
    return Position(x: lhs.x + rhs.x, y: lhs.y - rhs.y)
}

extension Position: Equatable {
}
