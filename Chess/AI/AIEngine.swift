//
//  AIEngine.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import GameplayKit

class AIEngine: NSObject, GKGameModel {

    var board = [[Piece?]]()
    var currentPlayer = AIPlayer.allPlayers[0]
    let chessGame: ChessGame

    var players: [GKGameModelPlayer]? {
        return AIPlayer.allPlayers
    }

    var activePlayer: GKGameModelPlayer? {
        return chessGame.currentPlayer.value == .white ? AIPlayer.allPlayers[0] : AIPlayer.allPlayers[1]
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = AIEngine(chessGame: chessGame)
        copy.setGameModel(self)
        return copy
    }

    init(chessGame: ChessGame) {
        self.chessGame = chessGame
        self.board = chessGame.board.value
        self.currentPlayer = chessGame.currentPlayer.value == .white ? AIPlayer.allPlayers[0] : AIPlayer.allPlayers[1]
    }

    func setGameModel(_ gameModel: GKGameModel) {
        if let engine = gameModel as? AIEngine {
            board = engine.board
            currentPlayer = engine.currentPlayer
        }
    }

    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        if let playerObject = player as? AIPlayer {
            // 2
            if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
                return nil
            }
            var moves = [AIMove]()

            let playerPices = chessGame.activePieces.filter { $0.player == playerObject.player }
            playerPices.forEach { piece in
                for x in 0...7 {
                    for y in 0...7 {
                        let move = Move(start: chessGame.indexOf(piece), end: Position(x: x, y: y))
                        if chessGame.pieceMovement.isValid(board: board, move: move, player: playerObject.player) {
                            let move = Move(start: chessGame.indexOf(piece), end: Position(x: x, y: y))
                            moves.append(AIMove(move: move))
                        }
                    }
                }
            }
            return moves
        }
        return nil
    }

    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        if let aiMove = gameModelUpdate as? AIMove {
            chessGame.didMove(move: aiMove.move)
            currentPlayer = chessGame.currentPlayer.value == .white ? AIPlayer.allPlayers[1] : AIPlayer.allPlayers[0]
        }
    }

    func isWin(for player: GKGameModelPlayer) -> Bool {
        return false // TODO
    }

    func score(for player: GKGameModelPlayer) -> Int {
        if let player = player as? AIPlayer {
            let selfPieces = chessGame.activePieces.filter { $0.player == player.player }.count
            let otherPieces = chessGame.activePieces.filter { $0.player != player.player }.count
            return selfPieces - otherPieces
        }
        return 0
    }
}
