//
//  Piece.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

class Piece {
    var x, y: Int
    let imageName: String
    
    init(x: Int, y: Int, imageName: String) {
        self.x = x
        self.y = y
        self.imageName = imageName
    }
}
