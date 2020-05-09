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
import GameplayKit

final class GameViewModel: ObservableObject {

    @Published var board: Board = []
    @Published var currentPlayer = Player.white
    @Published var whiteRemainigTime: String = ""
    @Published var blackRemainigTime: String = ""

    var pieces: [Piece] { chessGame.activePieces }

    private var disposables = Set<AnyCancellable>()
    private let chessGame: ChessGame
    private let minMaxStrategist: GKMinmaxStrategist

    init(gameMode: GameMode) {
        chessGame = ChessGame(gameMode: gameMode)
        minMaxStrategist = GKMinmaxStrategist()
        minMaxStrategist.maxLookAheadDepth = 4
        minMaxStrategist.randomSource = nil
        chessGame.currentPlayer.assign(to: \.currentPlayer, on: self).store(in: &disposables)
        chessGame.board.assign(to: \.board, on: self).store(in: &disposables)
        chessGame.whiteRemainingTime.map { $0.chessyTime() }.assign(to: \.whiteRemainigTime, on: self).store(in: &disposables)
        chessGame.blackRemainingTime.map { $0.chessyTime() }.assign(to: \.blackRemainigTime, on: self).store(in: &disposables)
    }
    
    
    func didMove(from startPosition: Position, to finalPosition: Position) {
        chessGame.didMove(from: startPosition, to: finalPosition)
        if currentPlayer == .black {
            let copy = chessGame.copy() as! ChessGame
            minMaxStrategist.gameModel = AIEngine(chessGame: copy)
            DispatchQueue.global(qos: .background).async {
                if let move = self.minMaxStrategist.bestMove(for: AIPlayer.allPlayers[1]) as? AIMove {
                    DispatchQueue.main.async {
                        self.chessGame.didMove(from: move.start, to: move.final)
                    }
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
