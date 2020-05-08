//
//  ContentView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel = GameViewModel()
    @State private var currentPiece: (Piece?, CGSize) = (nil, .zero)
    @State var isRotatingWhite = true

    var body: some View {

        ZStack {
            Image("pattern")
                .opacity(0.4)
                .blur(radius: 1)

            
            VStack(spacing: 0) {
                HUDView(name: "Nakamura, Hikaru", time: viewModel.blackRemainigTime, isCurrentPlayer: self.viewModel.currentPlayer == .black)

                ZStack(alignment: .bottomLeading) {
                    ChessBoardView()
                    ForEach(viewModel.pieces) { piece in
                        Image(piece.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(self.currentPiece.0 == piece ? 1.3 : 1)
                            .offset(self.currentPiece.0 == piece ? self.currentPiece.1 : self.viewModel.indexOf(piece).size)
                            .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.width / 8)
                            .gesture(self.dragGesture(piece))
                            .animation(.easeInOut(duration: 0.2))
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.width)

                HUDView(name: "Alicia Conde", time: viewModel.whiteRemainigTime, isCurrentPlayer: self.viewModel.currentPlayer == .white)
            }
        }.edgesIgnoringSafeArea(.top)
    }
    
    private func dragGesture(_ piece: Piece) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { dragValue in
                self.currentPiece = (piece, self.viewModel.indexOf(piece).size + dragValue.translation)
                self.viewModel.objectWillChange.send()
        }
        .onEnded {
            self.currentPiece = (nil, .zero)
            let finalPosition = self.viewModel.indexOf(piece) + Position($0.translation)
            self.viewModel.didMove(from: self.viewModel.indexOf(piece), to: finalPosition)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


