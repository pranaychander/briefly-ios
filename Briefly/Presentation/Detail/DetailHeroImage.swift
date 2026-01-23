//
//  DetailHeroImage.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct DetailHeroImage: View {

    let url: URL

    var body: some View {
        GeometryReader { geo in
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
        .frame(height: 240)
    }
}
