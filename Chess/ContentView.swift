//
//  ContentView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 06/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = GameViewModel()
    @State var currentPiece: (Piece?, CGSize) = (nil, .zero)

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack(spacing: 0) {
                ForEach((0...7).reversed(), id: \.self) { y in
                    HStack(spacing: 0) {
                        ForEach(0...7, id: \.self) { x in
                            ((x + y) %  2 == 1 ? Image("b_white") : Image("b_black"))
                                .resizable()
                        }
                    }
                }
            }
            ForEach(viewModel.pieces) { piece in
                Image(piece.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(self.currentPiece.0 == piece ? 1.3 : 1)
                    .offset(self.currentPiece.0 == piece ? self.currentPiece.1 : piece.position.size)
                    .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.width / 8)
                    .gesture(self.dragGesture(piece))

            }
        }
        .frame(maxHeight: UIScreen.main.bounds.width)

    }
    
    private func dragGesture(_ piece: Piece) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { dragValue in
                self.currentPiece = (piece, piece.position.size + dragValue.translation)
                self.viewModel.objectWillChange.send()
        }
        .onEnded {
            self.currentPiece = (nil, .zero)
            self.viewModel.didMove(piece, offset: Position($0.translation))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
