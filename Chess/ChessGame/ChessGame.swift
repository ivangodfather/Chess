//
//  ChessGame.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 08/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

typealias Board  = [[Piece?]]

class ChessGame {

    let board: CurrentValueSubject<Board, Never>
    let currentPlayer: CurrentValueSubject<Player, Never> = CurrentValueSubject(.white)
    let currentPlayerIsInCheck: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    let whiteRemainingTime: CurrentValueSubject<TimeInterval, Never>
    let blackRemainingTime: CurrentValueSubject<TimeInterval, Never>

    var activePieces: [Piece] { board.value.flatMap { $0 }.compactMap { $0 } }

    private let pieceMovement = PieceMovement()
    private var cancellables = Set<AnyCancellable>()

    init(playerTime: TimeInterval = 10 * 60, board: Board = ChessGame.loadInitialBoard()) {
        self.board = CurrentValueSubject(board)
        whiteRemainingTime = CurrentValueSubject(playerTime)
        blackRemainingTime = CurrentValueSubject(playerTime)
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { date  in
            (self.currentPlayer.value == .white ? self.whiteRemainingTime : self.blackRemainingTime).value -= 1
        }.store(in: &cancellables)
    }

    func didMove(from startPosition: Position, to finalPosition: Position) {
        if pieceMovement.isValid(board: board.value, start: startPosition, final: finalPosition, player: currentPlayer.value) {
            board.value[finalPosition] = board.value[startPosition]
            board.value[startPosition] = nil
            currentPlayer.send(currentPlayer.value == .white ? .black : .white)
            checkCurretPlayerIsInCheck()
        }
    }


    func indexOf(_ piece: Piece) -> Position {
        if let index = board.value.flatMap({ $0 }).firstIndex (where: { $0 == piece }) {
            return Position(x: index / 8, y: index % 8)
        }
        fatalError()
    }

    private func checkCurretPlayerIsInCheck() {
        let otherPlayer = currentPlayer.value == .white ? Player.black : .white
        let otherPlayerPieces = activePieces.filter { $0.player == otherPlayer }
        if let king = activePieces.filter ({ $0.player == currentPlayer.value && $0.type == .king }).first {
            for piece in otherPlayerPieces {
                if pieceMovement.isValid(board: board.value, start: indexOf(piece), final: indexOf(king), player: otherPlayer) {
                    currentPlayerIsInCheck.send(true)
                    return
                }
            }
        }
    }
}

enum Player {
    case white
    case black
}
