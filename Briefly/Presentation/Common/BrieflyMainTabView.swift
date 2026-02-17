//
//  BrieflyMainTabView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct BrieflyMainTabView: View {
    let container: DependencyContainer
    @State private var navigationState = AppNavigationState()

    var body: some View {
        TabView(selection: $navigationState.selectedTab) {
            
//           Tab(BrieflyTab.home.title, systemImage: BrieflyTab.home.icon, value: .home) {
//                NavigationStack {
//                    HomeView(viewModel: container.homeViewModel)
//                }
//            }
//
//            Tab(BrieflyTab.discover.title, systemImage: BrieflyTab.discover.icon, value: .discover, role: .search) {
//                DiscoverView()
//                    .toolbarRole(.browser)
//            }
//
//            Tab(BrieflyTab.saved.title, systemImage: BrieflyTab.saved.icon, value: .saved) {
//                SavedView()
//            }
            
            Tab(BrieflyTab.market.title, systemImage: BrieflyTab.market.icon, value: .market) {
                NavigationStack {
                    MarketView(viewModel: container.marketViewModel)
                }
            }

            Tab(BrieflyTab.profile.title, systemImage: BrieflyTab.profile.icon, value: .profile) {
                ProfileView(viewModel: container.profileViewModel)
            }
        }
        .environment(navigationState)
    }
}
