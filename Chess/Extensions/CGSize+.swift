//
//  CGSize+.swift
//  Chess
//
//  Created by Ivan Ruiz Monjo on 07/05/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
