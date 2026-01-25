//
//  AIActionsBottomSheet.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import SwiftUI

struct AIActionsBottomSheet: View {

    let onSelect: (AIAction) -> Void

    var body: some View {
        VStack(spacing: 16) {

            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.secondary)

            Text("Create with BRU")
                .font(.title3.bold())

            VStack(spacing: 12) {
                ForEach(AIAction.allCases) { action in
                    Button {
                        onSelect(action)
                    } label: {
                        AIActionCard(action: action)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
}
