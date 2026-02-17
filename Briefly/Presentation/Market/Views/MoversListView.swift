//
//  MoversListView.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import SwiftUI

struct MoversListView: View {

    let stocks: [Stock]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(stocks) { stock in
                StockRowView(stock: stock)
            }
        }
    }
}
