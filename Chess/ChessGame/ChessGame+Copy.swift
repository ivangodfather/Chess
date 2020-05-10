//
//  ChessGame+Copy.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension ChessGame: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = ChessGame(gameMode: GameMode(minuts: 30, increment: 0, mode: .computer))
        copy.currentPlayer.value = currentPlayer.value
        copy.board.value = board.value
        return copy
    }
}
