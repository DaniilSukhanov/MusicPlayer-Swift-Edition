//
//  AppColor.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import SwiftUI

struct AppColor {
    static let lightGray = Color(hex: 0xA5A5A5)
    static let darkGray = Color(hex: 0x433E48)
    static let white = Color(hex: 0xFFFFFF)
    static let purple2 = Color(hex: 0x892FE0)
    static let dark = Color(hex: 0x0F0817)
    static let purple1 = Color(hex: 0x9D1DCA)
    static let pink = Color(hex: 0xDB28A9)
    static let gradientBackground = Gradient(
        stops: [
            .init(color: Color(hex: 0x842ED8), location: 0.31),
            .init(color: Color(hex: 0xDB28A9), location: 0.59),
            .init(color: Color(hex: 0x9D1DCA), location: 1)
        ]
    )
    static let augularGradientBackground = AngularGradient.init(gradient: gradientBackground, center: .center, angle: .degrees(90))
}
