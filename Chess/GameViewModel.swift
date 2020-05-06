//
//  GameViewModel.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation


class GameViewModel: ObservableObject {
    @Published var pieces = [[Piece?]](repeating: [Piece?](repeating: nil, count:  8), count: 8)
    
    init() {
        pieces[0][0] = Rook(x: 0, y: 0, player: .white)
        pieces[1][0] = Knight(x: 1, y: 0, player: .white)
        pieces[2][0] = Bishop(x: 2, y: 0, player: .white)
        pieces[3][0] = Queen(x: 3, y: 0, player: .white)
        pieces[4][0] = King(x: 4, y: 0, player: .white)
        pieces[5][0] = Bishop(x: 5, y: 0, player: .white)
        pieces[6][0] = Knight(x: 6, y: 0, player: .white)
        pieces[7][0] = Rook(x: 0, y: 0, player: .white)
        pieces[0][1] = Pawn(x: 1, y: 0, player: .white)
        pieces[1][1] = Pawn(x: 1, y: 0, player: .white)
        pieces[2][1] = Pawn(x: 2, y: 0, player: .white)
        pieces[3][1] = Pawn(x: 3, y: 0, player: .white)
        pieces[4][1] = Pawn(x: 4, y: 0, player: .white)
        pieces[5][1] = Pawn(x: 5, y: 0, player: .white)
        pieces[6][1] = Pawn(x: 6, y: 0, player: .white)
        pieces[7][1] = Pawn(x: 7, y: 0, player: .white)
        pieces[0][7] = Rook(x: 0, y: 0, player: .black)
        pieces[1][7] = Knight(x: 1, y: 0, player: .black)
        pieces[2][7] = Bishop(x: 2, y: 0, player: .black)
        pieces[3][7] = Queen(x: 3, y: 0, player: .black)
        pieces[4][7] = King(x: 4, y: 0, player: .black)
        pieces[5][7] = Bishop(x: 5, y: 0, player: .black)
        pieces[6][7] = Knight(x: 6, y: 0, player: .black)
        pieces[7][7] = Rook(x: 7, y: 0, player: .black)
        pieces[0][6] = Pawn(x: 0, y: 0, player: .black)
        pieces[1][6] = Pawn(x: 1, y: 0, player: .black)
        pieces[2][6] = Pawn(x: 2, y: 0, player: .black)
        pieces[3][6] = Pawn(x: 3, y: 0, player: .black)
        pieces[4][6] = Pawn(x: 4, y: 0, player: .black)
        pieces[5][6] = Pawn(x: 5, y: 0, player: .black)
        pieces[6][6] = Pawn(x: 6, y: 0, player: .black)
        pieces[7][6] = Pawn(x: 7, y: 0, player: .black)
    }
}
