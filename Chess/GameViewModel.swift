//
//  GameViewModel.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import UIKit

class GameViewModel: ObservableObject {

    @Published var board = [[Piece?]](repeating: [Piece?](repeating: nil, count:  8), count: 8)
    var pieces: [Piece] { board.flatMap { $0 }.compactMap { $0 } }

    init() {
        loadBoardPieces()
    }
    
    
    func didMove(_ piece: Piece, offset: Position) {
        piece.position = piece.position + offset
        objectWillChange.send()
    }

    private func loadBoardPieces() {
        board[0][0] = Rook(x: 0, y: 0, player: .white)
        board[1][0] = Knight(x: 1, y: 0, player: .white)
        board[2][0] = Bishop(x: 2, y: 0, player: .white)
        board[3][0] = Queen(x: 3, y: 0, player: .white)
        board[4][0] = King(x: 4, y: 0, player: .white)
        board[5][0] = Bishop(x: 5, y: 0, player: .white)
        board[6][0] = Knight(x: 6, y: 0, player: .white)
        board[7][0] = Rook(x: 7, y: 0, player: .white)
        board[0][1] = Pawn(x: 0, y: 1, player: .white)
        board[1][1] = Pawn(x: 1, y: 1, player: .white)
        board[2][1] = Pawn(x: 2, y: 1, player: .white)
        board[3][1] = Pawn(x: 3, y: 1, player: .white)
        board[4][1] = Pawn(x: 4, y: 1, player: .white)
        board[5][1] = Pawn(x: 5, y: 1, player: .white)
        board[6][1] = Pawn(x: 6, y: 1, player: .white)
        board[7][1] = Pawn(x: 7, y: 1, player: .white)
        board[0][7] = Rook(x: 0, y: 7, player: .black)
        board[1][7] = Knight(x: 1, y: 7, player: .black)
        board[2][7] = Bishop(x: 2, y: 7, player: .black)
        board[3][7] = Queen(x: 3, y: 7, player: .black)
        board[4][7] = King(x: 4, y: 7, player: .black)
        board[5][7] = Bishop(x: 5, y: 7, player: .black)
        board[6][7] = Knight(x: 6, y: 7, player: .black)
        board[7][7] = Rook(x: 7, y: 7, player: .black)
        board[0][6] = Pawn(x: 0, y: 6, player: .black)
        board[1][6] = Pawn(x: 1, y: 6, player: .black)
        board[2][6] = Pawn(x: 2, y: 6, player: .black)
        board[3][6] = Pawn(x: 3, y: 6, player: .black)
        board[4][6] = Pawn(x: 4, y: 6, player: .black)
        board[5][6] = Pawn(x: 5, y: 6, player: .black)
        board[6][6] = Pawn(x: 6, y: 6, player: .black)
        board[7][6] = Pawn(x: 7, y: 6, player: .black)
    }
}
