//
//  PieceMovement+.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 11/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension PieceMovement {

    func validMovementsFor(position: Position, with piece: Piece, withBoard board: Board) -> [Move] {
        switch piece.type {
        case .knight:
            return validMovementsForKnight(from: position, piece: piece, andBoard: board)
        case .king:
            return validMovementsForKnight(from: position, piece: piece, andBoard: board)
        case .rook:
            return validMovementsForRook(from: position, piece: piece, andBoard: board)
        case .bishop:
            return validMovementsForBishop(from: position, piece: piece, andBoard: board)
        case .queen:
            return validMovementsForRook(from: position, piece: piece, andBoard: board) + validMovementsForBishop(from: position, piece: piece, andBoard: board)
        case .pawn:
            return validMovementsForPawn(from: position, piece: piece, andBoard: board)
        }
    }


    private func validMovementsForKnight(from startPosition: Position, piece: Piece, andBoard board: Board) -> [Move] {
        var validMovements = [Move]()
        let possibleIncrement = [(2, 1), (2, -1), (1, 2), (1, -2), (-1, 2), (-1, -2), (-2 , 1), (-2, -1)]
        for increment in possibleIncrement {
            let endPosition = Position(x: startPosition.x + increment.0, y: startPosition.y +  increment.1)
            let move = Move(start: startPosition, end: endPosition)
            if bounds ~= endPosition.x && bounds ~= endPosition.y  && isValid(board: board, move: move, player: piece.player) {
                validMovements.append(Move(start: startPosition, end: endPosition))
            }
        }
        return validMovements
    }

    private func validMovementsForKing(from startPosition: Position, piece: Piece, andBoard board: Board) -> [Move] {
        var validMovements = [Move]()
        let possibleIncrement = [(0, 1), (0, -1), (1, -1), (1, 0), (1, 1), (-1, -1), (-1 , 0), (-1, 1)]
        for increment in possibleIncrement {
            let endPosition = Position(x: startPosition.x + increment.0, y: startPosition.y +  increment.1)
            let move = Move(start: startPosition, end: endPosition)
            if bounds ~= endPosition.x && bounds ~= endPosition.y  && isValid(board: board, move: move, player: piece.player) {
                validMovements.append(Move(start: startPosition, end: endPosition))
            }
        }
        return validMovements
    }

    private func validMovementsForBishop(from startPosition: Position, piece: Piece, andBoard board: Board) -> [Move] {
        var validMovements = [Move]()

        // TopLeft
        var topLeft = Position(x: startPosition.x - 1, y: startPosition.y + 1)
        while bounds ~= topLeft.x   && bounds ~= topLeft.y {
            let move = Move(start: startPosition, end: topLeft)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            topLeft = Position(x: topLeft.x - 1, y: topLeft.y + 1)
        }

        // TopRight
        var topRight = Position(x: startPosition.x + 1, y: startPosition.y + 1)
        while bounds ~= topRight.x   && bounds ~= topRight.y {
            let move = Move(start: startPosition, end: topRight)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            topRight = Position(x: topRight.x + 1, y: topRight.y + 1)
        }

        // BottomLeft
        var bottomLeft = Position(x: startPosition.x - 1, y: startPosition.y - 1)
        while bounds ~= bottomLeft.x   && bounds ~= bottomLeft.y {
            let move = Move(start: startPosition, end: bottomLeft)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            bottomLeft = Position(x: bottomLeft.x - 1, y: bottomLeft.y - 1)
        }

        // BottomRight
        var bottomRight = Position(x: startPosition.x + 1, y: startPosition.y - 1)
        while bounds ~= bottomRight.x   && bounds ~= bottomRight.y {
            let move = Move(start: startPosition, end: bottomRight)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            bottomRight = Position(x: bottomRight.x + 1, y: bottomRight.y - 1)
        }


        return validMovements
    }

    private func validMovementsForRook(from startPosition: Position, piece: Piece, andBoard board: Board) -> [Move] {
        var validMovements = [Move]()

        // Left
        var left = Position(x: startPosition.x - 1, y: startPosition.y)
        while bounds ~= left.x   && bounds ~= left.y {
            let move = Move(start: startPosition, end: left)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            left = Position(x: left.x - 1, y: left.y)
        }

        // Right
        var right = Position(x: startPosition.x + 1, y: startPosition.y)
        while bounds ~= right.x   && bounds ~= right.y {
            let move = Move(start: startPosition, end: right)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            right = Position(x: right.x + 1, y: right.y)
        }

        // Top
        var top = Position(x: startPosition.x, y: startPosition.y + 1)
        while bounds ~= top.x   && bounds ~= top.y {
            let move = Move(start: startPosition, end: top)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            top = Position(x: top.x, y: top.y + 1)
        }

        // Bottom
        var bottom = Position(x: startPosition.x, y: startPosition.y - 1)
        while bounds ~= bottom.x   && bounds ~= bottom.y {
            let move = Move(start: startPosition, end: bottom)
            if isValid(board: board, move: move, player: piece.player) {
                validMovements.append(move)
            }
            bottom = Position(x: bottom.x, y: bottom.y - 1)
        }
        return validMovements
    }

    private func validMovementsForPawn(from startPosition: Position, piece: Piece, andBoard board: Board) -> [Move] {
        var validMovements = [Move]()
        let possibleIncrement = [(0, 2), (0, -2), (0, 1), (0, -1), (1, 1), (-1, 1), (-1, -1), (1, -1)]
        for increment in possibleIncrement {
            let endPosition = Position(x: startPosition.x + increment.0, y: startPosition.y +  increment.1)
            let move = Move(start: startPosition, end: endPosition)
            if bounds ~= endPosition.x && bounds ~= endPosition.y  && isValid(board: board, move: move, player: piece.player) {
                validMovements.append(Move(start: startPosition, end: endPosition))
            }
        }
        return validMovements
    }
}
