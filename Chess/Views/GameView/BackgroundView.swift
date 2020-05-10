//
//  BackgroundView.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 09/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("pattern")
            .opacity(0.05)
            .blur(radius: 1)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
