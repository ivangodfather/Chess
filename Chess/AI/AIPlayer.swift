//
//  AIPlayer.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

import GameplayKit

class AIPlayer: NSObject, GKGameModelPlayer {
    var playerId: Int

    let player: Player

    static var allPlayers = [AIPlayer(player: .white), AIPlayer(player: .black)]

    var opponent: AIPlayer {
        if player == .white {
            return AIPlayer.allPlayers[1]
        } else {
            return AIPlayer.allPlayers[0]
        }
    }

    init(player: Player) {
        self.player = player
        self.playerId = player.rawValue
        super.init()
    }
}
