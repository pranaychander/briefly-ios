//
//  CategoryImagePlaceholder.swift
//  Briefly
//
//  Created by Pranay Chander on 20/01/26.
//

import SwiftUI

struct CategoryImagePlaceholder: View {
    let topic: Topic

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.12))

            Image(systemName: iconName)
                .font(.system(size: 22))
                .foregroundStyle(.blue)
        }
    }

    private var iconName: String {
        switch topic {
        case .technology: return "cpu"
        case .business: return "chart.line.uptrend.xyaxis"
        case .sports: return "sportscourt"
        case .science: return "atom"
        default: return "newspaper"
        }
    }
}

