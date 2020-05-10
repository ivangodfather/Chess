//
//  ChessBoardView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 08/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct ChessBoardView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach((0...7).reversed(), id: \.self) { y in
                HStack(spacing: 0) {
                    ForEach(0...7, id: \.self) { x in
                        ((x + y).isMultiple(of: 2) ? Image("b_black") : Image("b_white"))
                            .resizable()
                    }
                }
            }
        }
    }
}
