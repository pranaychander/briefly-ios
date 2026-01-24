//
//  BrieflyMainTabView.swift
//  Briefly
//
//  Created by Pranay Chander on 15/01/26.
//

import SwiftUI

struct BrieflyMainTabView: View {
    let container: DependencyContainer
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(viewModel: container.homeViewModel)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark.fill")
                }
            
            ProfileView(viewModel: container.profileViewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
