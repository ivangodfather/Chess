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
    var id = UUID()
    var position: Position
    let imageName: String
    var currentPosition = CGSize.zero

    init(x: Int, y: Int, imageName: String) {
        self.position = Position(x: x, y: y)
        self.imageName = imageName
        currentPosition = Position(x: x, y: y).size
    }
}
