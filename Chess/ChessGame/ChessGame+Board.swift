//
//  Board.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 08/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension ChessGame {
    static func loadInitialBoard() -> Board {
        var board = [[Piece?]](repeating: [Piece?](repeating: nil, count:  8), count: 8)

        board[0][0] = Piece(type: .rook, player: .white)
        board[1][0] = Piece(type: .knight, player: .white)
        board[2][0] = Piece(type: .bishop, player: .white)
        board[3][0] = Piece(type: .queen, player: .white)
        board[4][0] = Piece(type: .king, player: .white)
        board[5][0] = Piece(type: .bishop, player: .white)
        board[6][0] = Piece(type: .knight, player: .white)
        board[7][0] = Piece(type: .rook, player: .white)

        board[0][1] = Piece(type: .pawn, player: .white)
        board[1][1] = Piece(type: .pawn, player: .white)
        board[2][1] = Piece(type: .pawn, player: .white)
        board[3][1] = Piece(type: .pawn, player: .white)
        board[4][1] = Piece(type: .pawn, player: .white)
        board[5][1] = Piece(type: .pawn, player: .white)
        board[6][1] = Piece(type: .pawn, player: .white)
        board[7][1] = Piece(type: .pawn, player: .white)

        board[0][7] = Piece(type: .rook, player: .black)
        board[1][7] = Piece(type: .knight, player: .black)
        board[2][7] = Piece(type: .bishop, player: .black)
        board[3][7] = Piece(type: .queen, player: .black)
        board[4][7] = Piece(type: .king, player: .black)
        board[5][7] = Piece(type: .bishop, player: .black)
        board[6][7] = Piece(type: .knight, player: .black)
        board[7][7] = Piece(type: .rook, player: .black)

        board[0][6] = Piece(type: .pawn, player: .black)
        board[1][6] = Piece(type: .pawn, player: .black)
        board[2][6] = Piece(type: .pawn, player: .black)
        board[3][6] = Piece(type: .pawn, player: .black)
        board[4][6] = Piece(type: .pawn, player: .black)
        board[5][6] = Piece(type: .pawn, player: .black)
        board[6][6] = Piece(type: .pawn, player: .black)
        board[7][6] = Piece(type: .pawn, player: .black)
        return board
    }
}
