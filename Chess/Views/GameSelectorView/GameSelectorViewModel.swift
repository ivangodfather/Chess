//
//  GameSelectorViewModel.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

final class GameSelectorViewModel {
    let computerGameModes = [
        GameMode(minuts: 1, increment: 0, mode: .computer),
        GameMode(minuts: 3, increment: 0, mode: .computer),
        GameMode(minuts: 10, increment: 0, mode: .computer),
    ]
    let localFriendModes = [
        GameMode(minuts: 1, increment: 0, mode: .localFriend),
        GameMode(minuts: 3, increment: 0, mode: .localFriend),
        GameMode(minuts: 10, increment: 0, mode: .localFriend),
    ]

}
