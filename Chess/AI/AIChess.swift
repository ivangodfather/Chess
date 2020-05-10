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

    init(chessGame: ChessGame) {
        self.chessGame = chessGame
        minMaxStrategist = GKMinmaxStrategist()
        minMaxStrategist.maxLookAheadDepth = 4
        minMaxStrategist.randomSource = GKRandomDistribution()
    }

    func bestMove(completion: @escaping (Move?) -> ())  {
        let copy = chessGame.copy() as! ChessGame
        minMaxStrategist.gameModel = AIEngine(chessGame: copy)
        DispatchQueue.global(qos: .background).async {
            if let aiMove = self.minMaxStrategist.bestMove(for: AIPlayer.allPlayers[1]) as? AIMove {
                DispatchQueue.main.async {
                    completion(aiMove.move)
                }
            }
        }
        completion(nil)
    }
}
