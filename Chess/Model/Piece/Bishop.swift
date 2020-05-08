//
//  Bishop.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

class Bishop: Piece {
    
    init(x: Int, y: Int, player: Player) {
        super.init(x: x, y: y, imageName: "bishop_\(player == .white ? "w" : "b")", player: player)
    }
}
