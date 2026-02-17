//
//  IndexCardView.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import SwiftUI

struct IndexCardView: View {

    let index: MarketIndex

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(index.name)
                .font(.caption)
                .foregroundColor(.secondary)

            Text("\(index.value, specifier: "%.2f")")
                .font(.headline)

            Text("\(index.changePercent, specifier: "%.2f")%")
                .font(.caption)
                .foregroundColor(index.changePercent >= 0 ? .green : .red)
        }
        .padding()
        .frame(width: 140)
        .background(.ultraThinMaterial)
        .cornerRadius(14)
    }
}
