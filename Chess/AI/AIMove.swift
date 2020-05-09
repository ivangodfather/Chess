//
//  AIMove.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import GameplayKit

class AIMove: NSObject, GKGameModelUpdate {
    var value: Int = 0

    let start: Position
    let final: Position

    init(start: Position, final: Position) {
        self.start = start
        self.final = final
    }
}
