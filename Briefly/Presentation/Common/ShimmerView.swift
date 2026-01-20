//
//  ShimmerView.swift
//  Briefly
//
//  Created by Pranay Chander on 20/01/26.
//

import SwiftUI

struct ShimmerView: View {
    @State private var offset: CGFloat = -1

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.25))
            .overlay(
                GeometryReader { geo in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, .white.opacity(0.6), .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .rotationEffect(.degrees(25))
                        .offset(x: offset * geo.size.width * 2)
                }
            )
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    offset = 1
                }
            }
            .clipped()
    }
}

