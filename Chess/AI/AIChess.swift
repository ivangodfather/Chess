//
//  AIChess.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import GameplayKit

class AIChess {

    private let chessGame: ChessGame
    private let minMaxStrategist: GKMinmaxStrategist
    var isThinking = false

    init(chessGame: ChessGame) {
        self.chessGame = chessGame
        minMaxStrategist = GKMinmaxStrategist()
        minMaxStrategist.maxLookAheadDepth = 3
        minMaxStrategist.randomSource = nil
    }

    func bestMove(completion: @escaping (Move?) -> ())  {
        isThinking = true
        let copy = chessGame.copy() as! ChessGame
        minMaxStrategist.gameModel = AIEngine(chessGame: copy)
        DispatchQueue.global(qos: .background).async {
            if let aiMove = self.minMaxStrategist.randomMove(for: AIPlayer.allPlayers[1], fromNumberOfBestMoves: 3) as? AIMove {
                DispatchQueue.main.async {
                    self.isThinking = false
                    completion(aiMove.move)
                }
            }
        }
        completion(nil)
    }
}
