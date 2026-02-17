//
//  MoversPickerView.swift
//  Briefly
//
//  Created by Pranay Chander on 26/01/26.
//

import SwiftUI

struct MoversPickerView: View {

    @Binding var selection: MoverType

    var body: some View {
        Picker("Movers", selection: $selection) {
            ForEach(MoverType.allCases) {
                Text($0.rawValue).tag($0)
            }
        }
        .pickerStyle(.segmented)
    }
}
