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
    var body: some View {
        VStack(spacing: 0) {
            ForEach((0...7).reversed(), id: \.self) { y in
                HStack(spacing: 0) {
                    ForEach(0...7, id: \.self) { x in
                        ZStack {
                            ((x + y) %  2 == 1 ? Image("b_white") : Image("b_black"))
                                .resizable()
                            if self.viewModel.pieces[x][y] != nil {
                                Image(uiImage: UIImage(named: self.viewModel.pieces[x][y]!.imageName)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(self.viewModel.pieces[x][y]!.currentPosition)
                            }
                        }
                        .gesture(self.dragGesture(x, y))
                    }
                }
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.width)
    }
    
    private func dragGesture(_ x: Int,_ y: Int) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { dragValue in
                if self.viewModel.pieces[x][y] != nil {
                    self.viewModel.pieces[x][y]!.currentPosition = CGSize(
                        width: self.viewModel.pieces[x][y]!.newPosition.width + dragValue.translation.width,
                        height: self.viewModel.pieces[x][y]!.newPosition.height + dragValue.translation.height
                    )
                    self.viewModel.objectWillChange.send()
                }
        }
        .onEnded { dragValue in
            if self.viewModel.pieces[x][y] != nil {
                self.viewModel.pieces[x][y]!.newPosition = self.viewModel.pieces[x][y]!.currentPosition
                self.viewModel.objectWillChange.send()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
