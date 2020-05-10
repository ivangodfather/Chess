//
//  GameSelectorView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct GameSelectorView: View {

    private let viewModel = GameSelectorViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                PersonView(systemName: "person")
                .padding(.leading)
                HStack {
                    ForEach(viewModel.computerGameModes) {
                        GameModeView(gameMode: $0)
                    }
                }
                PersonView(systemName: "person.2")
                .padding(.leading)
                .padding(.top, 32)
                HStack {
                    ForEach(viewModel.localFriendModes) {
                        GameModeView(gameMode: $0)
                    }
                }
                Spacer()

            }
            .padding(.top, 32)
            .navigationBarTitle("Chess")
        }
    }
}

struct GameSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectorView()
    }
}
