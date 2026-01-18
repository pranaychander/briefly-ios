//
//  TopBarView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct TopBarView: View {

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image("appLogo")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Briefly")
                    .font(.title)
                    .bold()
            }

            Spacer()
            HStack(spacing: 12) {
                
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .padding(3)
                    .background(Circle().stroke(style: StrokeStyle(lineWidth: 1)))
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
