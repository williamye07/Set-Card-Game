//
//  CircleView.swift
//  Set-Card-Game
//
//  Created by William Ye on 2021-04-15.
//

import SwiftUI

struct CircleView: View {
    var color: Color
    var opacity: Double
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .opacity(opacity)
            Circle()
                .strokeBorder(color, lineWidth: 1)
        }
        .frame(width: width, height: height)
    }
}
