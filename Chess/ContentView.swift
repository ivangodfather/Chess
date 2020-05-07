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
        ZStack {
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
            VStack(spacing: 0) {
                ForEach((0...7).reversed(), id: \.self) { y in
                    HStack(spacing: 0) {
                        ForEach(0...7, id: \.self) { x in
                           (self.viewModel.pieces[x][y] != nil ?
                            Image(uiImage: UIImage(named: self.viewModel.pieces[x][y]!.imageName)!)
                                    : Image(""))
                            .resizable()
                            .offset(self.viewModel.pieces[x][y] != nil ? self.viewModel.pieces[x][y]!.currentPosition : .zero)
                            .gesture(self.dragGesture(x, y))
                        }
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
            self.viewModel.didMove(x: x, y: y,
                                   xOffset: Int((dragValue.translation.width / (UIScreen.main.bounds.width / 8)).rounded()),
                                   yOffset: Int((dragValue.translation.height / (UIScreen.main.bounds.width / 8)).rounded())
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
