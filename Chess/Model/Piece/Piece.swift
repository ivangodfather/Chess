//
//  Piece.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import UIKit

class Piece: Identifiable {
    let uuid = UUID()

    var position: Position
    let imageName: String
    let player: Player

    init(x: Int, y: Int, imageName: String, player: Player) {
        self.position = Position(x: x, y: y)
        self.imageName = imageName
        self.player = player
    }
}

extension Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
