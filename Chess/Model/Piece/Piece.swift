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
    var x, y: Int
    let imageName: String
    var currentPosition = CGSize.zero
    var newPosition = CGSize.zero
    
    init(x: Int, y: Int, imageName: String) {
        self.x = x
        self.y = y
        self.imageName = imageName
    }

    struct Position {
        let x, y: Int
    }
}
