//
//  StockRowView.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import SwiftUI

struct StockRowView: View {

    let stock: Stock

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .font(.headline)

                Text("\(stock.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text("\(stock.changePercent, specifier: "%.2f")%")
                .font(.subheadline.bold())
                .foregroundColor(stock.changePercent >= 0 ? .green : .red)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
