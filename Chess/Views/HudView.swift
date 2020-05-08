//
//  HudView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 08/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI


struct HUDView: View {

    let name: String
    let time: String

    var body: some View {
        HStack {
            Text(name)
                .fontWeight(.bold)
                .padding(.horizontal)
            Spacer()
            HStack {
                Image(systemName: "clock")
                Text(time)
            }

            .padding()
            .background(Color.green)

        }

        .foregroundColor(.white)
        .font(Font.headline.weight(.bold))
        .background(Color.black.opacity(0.7))
    }
}

struct HudView_Previews: PreviewProvider {
    static var previews: some View {
        HUDView(name: "Iván Ruiz", time: "04:03.15")
    }
}
