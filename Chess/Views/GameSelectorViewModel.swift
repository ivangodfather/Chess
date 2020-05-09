//
//  GameSelectorViewModel.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

final class GameSelectorViewModel {
    let gameModes = [
        GameMode(minuts: 1, increment: 0, mode: .bullet),
        GameMode(minuts: 3, increment: 0, mode: .blitz),
        GameMode(minuts: 10, increment: 0, mode: .rapid),
    ]

}
