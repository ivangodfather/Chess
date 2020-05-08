//
//  PieceType.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 08/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

enum PieceType {
    case pawn
    case rook
    case knight
    case bishop
    case queen
    case king
}

extension Piece {
    var imageName: String {
        switch type {
        case .pawn: return "pawn_\(player == .white ? "w" : "b")"
        case .rook: return "rook_\(player == .white ? "w" : "b")"
        case .knight: return "knight_\(player == .white ? "w" : "b")"
        case .bishop: return "bishop_\(player == .white ? "w" : "b")"
        case .queen: return "queen_\(player == .white ? "w" : "b")"
        case .king: return "king_\(player == .white ? "w" : "b")"
        }
    }
}
