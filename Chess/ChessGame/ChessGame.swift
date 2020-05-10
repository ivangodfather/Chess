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

    var board: CurrentValueSubject<Board, Never> = CurrentValueSubject([])
    let currentPlayer: CurrentValueSubject<Player, Never> = CurrentValueSubject(.white)
    let currentPlayerIsInCheck: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    let whiteRemainingTime: CurrentValueSubject<TimeInterval, Never>
    let blackRemainingTime: CurrentValueSubject<TimeInterval, Never>
    var activePieces: [Piece] { board.value.flatMap { $0 }.compactMap { $0 } }

    let pieceMovement = PieceMovement()
    private var cancellables = Set<AnyCancellable>()
    private let gameMode: GameMode
    private var timer = Timer.publish(every: 1.0, on: .main, in: .common)

    init(gameMode: GameMode) {
        self.gameMode = gameMode
        whiteRemainingTime = CurrentValueSubject(Double(gameMode.minuts * 60))
        blackRemainingTime = CurrentValueSubject(Double(gameMode.minuts * 60))
    }

    func play(move: Move) {
        if pieceMovement.isValid(board: board.value, move: move, player: currentPlayer.value) {
            board.value[move.end] = board.value[move.start]
            board.value[move.start] = nil
            (currentPlayer.value == .white ? whiteRemainingTime : blackRemainingTime).value += Double(gameMode.increment)
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

    func start() {
        cancellables.removeAll()
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
        timer.connect().store(in: &cancellables)
        board.value = ChessGame.loadInitialBoard()
        currentPlayer.value = .white
        whiteRemainingTime.value = Double(gameMode.minuts * 60)
        blackRemainingTime.value = Double(gameMode.minuts * 60)
        startClocks()
    }

    private func checkCurretPlayerIsInCheck() {
        let otherPlayer = currentPlayer.value == .white ? Player.black : .white
        let otherPlayerPieces = activePieces.filter { $0.player == otherPlayer }
        if let king = activePieces.filter ({ $0.player == currentPlayer.value && $0.type == .king }).first {
            for piece in otherPlayerPieces {
                let move = Move(start: indexOf(piece), end: indexOf(king))
                if pieceMovement.isValid(board: board.value, move: move, player: otherPlayer) {
                    currentPlayerIsInCheck.send(true)
                    return
                }
            }
        }
    }

    private func startClocks() {
        timer.sink { date  in
            (self.currentPlayer.value == .white ? self.whiteRemainingTime : self.blackRemainingTime).value -= 1
        }.store(in: &cancellables)
    }
}
