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
                            }
                        }
                    }
                }
            }
        }.frame(maxHeight: UIScreen.main.bounds.width)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
