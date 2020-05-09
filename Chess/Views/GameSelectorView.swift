//
//  GameSelectorView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI


struct GameMode: CustomStringConvertible, Identifiable {
    let id = UUID()

    let minuts: Int
    let increment: Int
    let mode: Mode

    var description: String {
        "\(minuts)+\(increment)"
    }

    enum Mode: String {
        case bullet
        case blitz
        case rapid
    }
}

struct GameSelectorView: View {

    private let viewModel = GameSelectorViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    Image("bishop")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                        .padding(64)
                        .blur(radius: 1)
                    HStack {
                        ForEach(viewModel.gameModes) { gameMode in
                            NavigationLink(destination: GameView(gameMode: gameMode)) {
                                VStack {
                                    Text(gameMode.description)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                    Text(gameMode.mode.rawValue.capitalized)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                                .frame(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.width / 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white, lineWidth: 4)
                                )
                                .background(Color.black.opacity(0.5))


                            }
                        }


                    }
                    Spacer()

                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct GameSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectorView()
    }
}
