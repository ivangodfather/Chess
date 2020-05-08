//
//  ChessGame.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 08/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

class ChessGame {

    var board: CurrentValueSubject<Board, Never>
    var currentPlayer: CurrentValueSubject<Player, Never>
    var whiteRemainingTime: CurrentValueSubject<TimeInterval, Never>
    var blackRemainingTime: CurrentValueSubject<TimeInterval, Never>

    var pieceMovement = PieceMovement()

    var activePieces: [Piece] { board.value.flatMap { $0 }.compactMap { $0 } }


    init(playerTime: TimeInterval = 10 * 60) {
        currentPlayer = CurrentValueSubject(.white)
        whiteRemainingTime = CurrentValueSubject(playerTime)
        blackRemainingTime = CurrentValueSubject(playerTime)
        board = CurrentValueSubject(ChessGame.loadInitialBoard())
    }

    func didMove(from startPosition: Position, to finalPosition: Position) {
        if pieceMovement.isValid(board: board.value, start: startPosition, final: finalPosition, player: currentPlayer.value) {
            board.value[finalPosition] = board.value[startPosition]
            board.value[startPosition] = nil
            currentPlayer.send(currentPlayer.value == .white ? .black : .white)
        }
    }


    func indexOf(_ piece: Piece) -> Position {
        if let index = board.value.flatMap({ $0 }).firstIndex (where: { $0 == piece }) {
            return Position(x: index / 8, y: index % 8)
        }
        fatalError()
    }
}

enum Player {
    case white
    case black
}
