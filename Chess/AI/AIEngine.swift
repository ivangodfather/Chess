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

    let chessGame: ChessGame

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
            if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
                return nil
            }
            var moves = [AIMove]()

            let playerPices = chessGame.activePieces.filter { $0.player == playerObject.player }
            playerPices.forEach { piece in
                let newMoves = chessGame.pieceMovement
                    .validMovementsFor(position: chessGame.indexOf(piece), with: piece, withBoard: chessGame.board.value)
                    .map { AIMove(move: $0) }
                moves.append(contentsOf: newMoves)
            }
            return moves.shuffled()
        }
        return nil
    }

    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        if let aiMove = gameModelUpdate as? AIMove {
            chessGame.play(move: aiMove.move)
        }
    }

    func isWin(for player: GKGameModelPlayer) -> Bool {
        return false // TODO
    }

    func score(for player: GKGameModelPlayer) -> Int {
        if let player = player as? AIPlayer {
            let selfPieces = chessGame.activePieces.filter { $0.player == player.player }.map { $0.type.value }.reduce(0,+)
            let otherPieces = chessGame.activePieces.filter { $0.player != player.player }.map { $0.type.value }.reduce(0,+)
            return selfPieces - otherPieces
        }
        return 0
    }
}
