//
//  AIActionSheet.swift
//  Briefly
//
//  Created by Pranay Chander on 21/01/26.
//

import SwiftUI

struct AIActionSheet: View {

    let onSelect: (AIAction) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List(AIAction.allCases) { action in
                Button {
                    dismiss()
                    onSelect(action)
                } label: {
                    Text(action.displayName)
                }
            }
            .navigationTitle("AI Actions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
