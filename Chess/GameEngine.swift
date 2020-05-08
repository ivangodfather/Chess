//
//  GameEngine.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 07/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

typealias Board  = [[Piece?]]

struct GameEngine {

    private let bounds = 0...7

    func isValidMove(board: Board, start: Position, final: Position, player: Player) -> Bool {
        guard start != final,
            let piece = board[start],
            bounds ~= final.x && bounds ~= final.y,
            piece.player == player else {
            return false
        }

        if let boardPlayer = board[final]?.player, boardPlayer == player {
            return false
        }

        switch piece {
        case is Pawn: return validPawnMove(board: board, start: start, final: final, player: player)
        case is Knight: return validKnightMove(start: start, final: final)
        case is King: return validKingMove(start: start, final: final)
        case is Rook: return validRookMove(board: board, start: start, final: final)
        case is Bishop: return validBishopMove(board: board, start: start, final: final)
        case is Queen: return validBishopMove(board: board, start: start, final: final) || validRookMove(board: board, start: start, final: final)
        default: fatalError()
        }
    }

    private func validPawnMove(board: Board, start: Position, final: Position, player: Player) -> Bool {
        if abs(start.x - final.x)  == 1 {
            guard let boardplayer = board[final]?.player, boardplayer != player else {
                return false
            }
            return final.y - start.y + (player == .white ? -1 : 1) == 0
        }
        if start.x == final.x {
            if (start.y - final.y + (player == .white ? 1 : -1)) == 0 && board[final] == nil {
                return true
            }
            let middle = start.y + (.white == player ? 1 : -1)
            if (start.y - final.y + (player == .white ? 2 : -2)) == 0 && board[final] == nil && board[start.x][middle] == nil {
                return true
            }
        }
        return false
    }

    private func validKnightMove(start: Position, final: Position) -> Bool {
       (abs(start.x - final.x) == 1 && abs(start.y - final.y) == 2) || (abs(start.x - final.x) == 2 && abs(start.y - final.y) == 1)
    }

    private func validKingMove(start: Position, final: Position) -> Bool {
        [0, 1].contains(abs(start.x - final.x)) && [0, 1].contains(abs(start.y - final.y))
    }

    private func validRookMove(board: Board, start: Position, final: Position) -> Bool {
        guard start.x == final.x || start.y == final.y else {
            return false
        }
        if abs(start.y - final.y) == 1 || abs(start.x - final.x) == 1 {
            return true
        }
        if start.x == final.x {
            let range = min(start.y, final.y) + 1...max(start.y, final.y) - 1
            for y in range {
                if board[start.x][y] != nil {
                    return false
                }
            }
        }
        if start.y == final.y {
            let range = min(start.x, final.x) + 1...max(start.x, final.x) - 1
            for x in range {
                if board[x][start.y] != nil {
                    return false
                }
            }
        }
        return true
    }

    private func validBishopMove(board: Board, start: Position, final: Position) -> Bool {
        guard abs(start.x - final.x) == abs(start.y - final.y) else {
            return false
        }
        if abs(start.x - final.x) == 1 { return true }
        let squaresToCheck = abs(start.x - final.x) - 1
        let rangeX: [Int]
        if start.x < final.x {
            rangeX = (start.x + 1...final.x - 1).map { $0 }
        } else {
            rangeX = (final.x + 1...start.x - 1).map { $0 }.reversed()
        }
        let rangeY: [Int]
        if start.y < final.y {
            rangeY = (start.y + 1...final.y - 1).map { $0 }
        } else {
            rangeY = (final.y + 1...start.y - 1).map { $0 }.reversed()
        }
        for x in 0..<squaresToCheck {
            if board[rangeX[x]][rangeY[x]] != nil {
                return false
            }
        }
        return true
    }
}
