//
//  HomeFeedPickerView.swift
//  Briefly
//
//  Created by Pranay Chander on 17/01/26.
//

import SwiftUI

struct HomeFeedPickerView: View {

    let feeds: [HomeFeedType]
    @Binding var selection: HomeFeedType

    init(
        feeds: [HomeFeedType] = HomeFeedType.allCases,
        selection: Binding<HomeFeedType>
    ) {
        self.feeds = feeds
        self._selection = selection
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(feeds, id: \.self) { feed in
                    HomeFeedTabView(
                        title: feed.displayName,
                        isSelected: selection == feed
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selection = feed
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
