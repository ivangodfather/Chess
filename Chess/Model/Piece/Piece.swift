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
    var currentPosition = CGSize.zero

    var position: Position {
        didSet { currentPosition = position.size }
    }
    let imageName: String
    let player: Player


    init(x: Int, y: Int, imageName: String, player: Player) {
        self.position = Position(x: x, y: y)
        self.imageName = imageName
        self.player = player
        currentPosition = Position(x: x, y: y).size
    }
}
