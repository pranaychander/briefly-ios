//
//  IndicesRowView.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import SwiftUI

struct IndicesRowView: View {

    let indices: [MarketIndex]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(indices) { index in
                    IndexCardView(index: index)
                }
            }
        }
    }
}
