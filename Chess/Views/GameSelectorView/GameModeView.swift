//
//  GameModeView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 10/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct GameModeView: View {
    var gameMode: GameMode
    var body: some View {
        VStack {
            NavigationLink(destination: GameView(gameMode: gameMode)) {
                VStack {
                    Text(gameMode.description)
                        .font(.title)
                        .foregroundColor(Color.primary)
                        .fontWeight(.light)
                    Text(gameMode.mode.rawValue.capitalized)
                        .font(.headline)
                        .foregroundColor(Color.primary)
                        .fontWeight(.light)
                }
                .frame(width: UIScreen.main.bounds.width / 3.3, height: UIScreen.main.bounds.width / 3.5)
                .background(Color.secondary.opacity(0.2))
            }
        }
        .cornerRadius(6)
    }
}

struct PersonView: View {
    var systemName: String
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .font(Font.system(size: 32, weight: .light, design: .default))
                .imageScale(.large)
                .foregroundColor(Color.primary)
            Spacer()
        }
    }
}

struct GameModeView_Previews: PreviewProvider {
        static var previews: some View {
            GameModeView(gameMode: GameMode(minuts: 3, increment: 0, mode: .computer))
    }
}
