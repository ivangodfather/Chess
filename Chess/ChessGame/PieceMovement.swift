//
//  GameEngine.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 07/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct PieceMovement {

    private let bounds = 0...7

    func isValid(board: Board, move: Move, player: Player) -> Bool {
        guard move.start != move.end,
            let piece = board[move.start],
            bounds ~= move.end.x && bounds ~= move.end.y,
            piece.player == player else {
            return false
        }

        if let boardPlayer = board[move.end]?.player, boardPlayer == player {
            return false
        }

        switch piece.type {
        case .pawn: return validPawnMove(board: board, move: move, player: player)
        case .knight: return validKnightMove( move: move)
        case .king: return validKingMove(move: move)
        case .rook: return validRookMove(board: board, move: move)
        case .bishop: return validBishopMove(board: board, move: move)
        case .queen: return validBishopMove(board: board, move: move) || validRookMove(board: board, move: move)
        }
    }

    private func validPawnMove(board: Board, move: Move, player: Player) -> Bool {
        if abs(move.start.x - move.end.x)  == 1 {
            guard let boardplayer = board[move.end]?.player, boardplayer != player else {
                return false
            }
            return move.end.y - move.start.y + (player == .white ? -1 : 1) == 0
        }
        if move.start.x == move.end.x {
            if (move.start.y - move.end.y + (player == .white ? 1 : -1)) == 0 && board[move.end] == nil {
                return true
            }
            let middle = move.start.y + (.white == player ? 1 : -1)
            if (move.start.y - move.end.y + (player == .white ? 2 : -2)) == 0
                && board[move.end] == nil
                && board[move.start.x][middle] == nil
                && ((player == .white && move.start.y == 1) || (player == .black && move.start.y == 6))   {
                return true
            }
        }
        return false
    }

    private func validKnightMove(move: Move) -> Bool {
       (abs(move.start.x - move.end.x) == 1 && abs(move.start.y - move.end.y) == 2) || (abs(move.start.x - move.end.x) == 2 && abs(move.start.y - move.end.y) == 1)
    }

    private func validKingMove(move: Move) -> Bool {
        [0, 1].contains(abs(move.start.x - move.end.x)) && [0, 1].contains(abs(move.start.y - move.end.y))
    }

    private func validRookMove(board: Board, move: Move) -> Bool {
        guard move.start.x == move.end.x || move.start.y == move.end.y else {
            return false
        }
        if abs(move.start.y - move.end.y) == 1 || abs(move.start.x - move.end.x) == 1 {
            return true
        }
        if move.start.x == move.end.x {
            let range = min(move.start.y, move.end.y) + 1...max(move.start.y, move.end.y) - 1
            for y in range {
                if board[move.start.x][y] != nil {
                    return false
                }
            }
        }
        if move.start.y == move.end.y {
            let range = min(move.start.x, move.end.x) + 1...max(move.start.x, move.end.x) - 1
            for x in range {
                if board[x][move.start.y] != nil {
                    return false
                }
            }
        }
        return true
    }

    private func validBishopMove(board: Board, move: Move) -> Bool {
        guard abs(move.start.x - move.end.x) == abs(move.start.y - move.end.y) else {
            return false
        }
        if abs(move.start.x - move.end.x) == 1 { return true }
        let squaresToCheck = abs(move.start.x - move.end.x) - 1
        let rangeX: [Int]
        if move.start.x < move.end.x {
            rangeX = (move.start.x + 1...move.end.x - 1).map { $0 }
        } else {
            rangeX = (move.end.x + 1...move.start.x - 1).map { $0 }.reversed()
        }
        let rangeY: [Int]
        if move.start.y < move.end.y {
            rangeY = (move.start.y + 1...move.end.y - 1).map { $0 }
        } else {
            rangeY = (move.end.y + 1...move.start.y - 1).map { $0 }.reversed()
        }
        for x in 0..<squaresToCheck {
            if board[rangeX[x]][rangeY[x]] != nil {
                return false
            }
        }
        return true
    }
}
