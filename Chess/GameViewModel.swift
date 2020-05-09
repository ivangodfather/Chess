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

struct Move {
    let start: Position
    let end: Position
}

final class GameViewModel: ObservableObject {

    @Published var board: Board = []
    @Published var currentPlayer = Player.white
    @Published var whiteRemainigTime: String = ""
    @Published var blackRemainigTime: String = ""
    var pieces: [Piece] { chessGame.activePieces }

    private var disposables = Set<AnyCancellable>()
    private let chessGame: ChessGame
    private let ai: AIChess


    init(gameMode: GameMode) {
        chessGame = ChessGame(gameMode: gameMode)
        ai = AIChess(chessGame: chessGame)
        chessGame.currentPlayer.assign(to: \.currentPlayer, on: self).store(in: &disposables)
        chessGame.board.assign(to: \.board, on: self).store(in: &disposables)
        chessGame.whiteRemainingTime.map { $0.chessyTime() }.assign(to: \.whiteRemainigTime, on: self).store(in: &disposables)
        chessGame.blackRemainingTime.map { $0.chessyTime() }.assign(to: \.blackRemainigTime, on: self).store(in: &disposables)
    }
    
    
    func didMove(from startPosition: Position, to finalPosition: Position) {
        chessGame.didMove(from: startPosition, to: finalPosition)
        if currentPlayer == .black {
            ai.bestMove { move in
                if let move = move {
                    self.chessGame.didMove(from: move.start, to: move.end)
                }
            }
        }
    }

    func indexOf(_ piece: Piece) -> Position {
        chessGame.indexOf(piece)
    }
}

extension ChessGame: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = ChessGame(gameMode: GameMode(minuts: 30, increment: 0, mode: .blitz))
        copy.currentPlayer.value = currentPlayer.value
        copy.board.value = board.value
        return copy
    }
}
