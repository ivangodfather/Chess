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

    var chessGame: ChessGame

    var players: [GKGameModelPlayer]? {
        return AIPlayer.allPlayers
    }

    var activePlayer: GKGameModelPlayer? {
        return chessGame.currentPlayer.value == .white ? AIPlayer.allPlayers[0] : AIPlayer.allPlayers[1]
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = AIEngine(chessGame: chessGame.copy() as! ChessGame)
        copy.setGameModel(self)
        return copy
    }

    init(chessGame: ChessGame) {
        self.chessGame = chessGame
    }

    func setGameModel(_ gameModel: GKGameModel) {
        if let engine = gameModel as? AIEngine {
            chessGame.board.value = engine.chessGame.board.value
            chessGame.currentPlayer.value = engine.chessGame.currentPlayer.value
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
                        if chessGame.pieceMovement.isValid(board: chessGame.board.value, move: move, player: playerObject.player) {
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
//            currentPlayer = chessGame.pa currentPlayer.opponent
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
