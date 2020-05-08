//
//  Array+.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 07/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension Array where Element == [Piece?] {
    subscript(_ position: Position) -> Piece? {
        get {
            self[position.x][position.y]
        }
        set(newValue) {
            self[position.x][position.y] = newValue
        }
    }
}
