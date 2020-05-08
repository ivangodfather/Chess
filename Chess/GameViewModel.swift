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

    @Published var board: Board
    @Published var currentPlayer = Player.white
    var pieces: [Piece] { board.flatMap { $0 }.compactMap { $0 } }

    private let engine: GameEngine

    init() {
        engine = GameEngine()
        board = Piece.loadInitialBoard()
    }
    
    
    func didMove(_ piece: Piece, offset: Position) {
        if engine.isValidMove(board: board, start: positionForPiece(piece), final: positionForPiece(piece) + offset, player: currentPlayer) {
            let oldPosition = positionForPiece(piece)
            let newPosition = oldPosition + offset
            board[newPosition] = piece
            board[oldPosition] = nil
            currentPlayer = currentPlayer == .white ? .black : .white

        } 
        objectWillChange.send()
    }

    func positionForPiece(_ piece: Piece) -> Position {
        if let index = board.flatMap({ $0 }).firstIndex (where: { $0 == piece }) {
            return Position(x: index / 8, y: index % 8)
        }
        fatalError()
    }
}
