//
//  GameMode.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 10/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct GameMode: CustomStringConvertible, Identifiable {
    let id = UUID()

    let minuts: Int
    let increment: Int
    let mode: Mode

    var description: String {
        "\(minuts)+\(increment)"
    }

    enum Mode: String {
        case computer
        case localFriend = "Friend"
    }
}
