//
//  GameViewModel.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import UIKit

final class GameViewModel: ObservableObject {

    private let engine: GameEngine

    @Published var board: Board
    @Published var currentPlayer = Player.white
    var pieces: [Piece] { board.flatMap { $0 }.compactMap { $0 } }

    init() {
        engine = GameEngine()
        board = Piece.loadInitialBoard()
    }
    
    
    func didMove(_ piece: Piece, offset: Position) {
        if engine.isValidMove(board: board, start: piece.position, final: piece.position + offset, player: currentPlayer) {
            let newPosition = piece.position + offset
            board[newPosition] = piece
            board[piece.position] = nil
            piece.position = newPosition
            currentPlayer = currentPlayer == .white ? .black : .white

        } else {
            piece.currentPosition = piece.position.size
        }
        objectWillChange.send()
    }

}
