//
//  GameViewModel.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class GameViewModel: ObservableObject {

    @Published var board: Board = []
    @Published var currentPlayer = Player.white
    var pieces: [Piece] { chessGame.activePieces }

    private var disposables = Set<AnyCancellable>()

    private let chessGame: ChessGame

    init() {
        chessGame = ChessGame()
        chessGame.currentPlayer.assign(to: \.currentPlayer, on: self).store(in: &disposables)
        chessGame.board.assign(to: \.board, on: self).store(in: &disposables)
    }
    
    
    func didMove(from startPosition: Position, to finalPosition: Position) {
        chessGame.didMove(from: startPosition, to: finalPosition)
    }

    func indexOf(_ piece: Piece) -> Position {
        chessGame.indexOf(piece)
    }
}
