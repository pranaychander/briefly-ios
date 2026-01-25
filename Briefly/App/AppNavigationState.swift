//
//  AppNavigationState.swift
//  Briefly
//
//  Created by Pranay Chander on 25/01/26.
//

import Foundation

@Observable
final class AppNavigationState {
    var selectedTab: BrieflyTab = .home
}

enum BrieflyTab: Hashable {
    case home
    case profile
    case discover
    case saved
    case market
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .profile: return "Profile"
        case .discover: return "Discover"
        case .saved: return "Saved"
        case .market: return "Markets"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .profile: return "person.fill"
        case .discover: return "magnifyingglass"
        case .saved: return "bookmark.fill"
        case .market: return "chart.line.uptrend.xyaxis"
        }
    }
}


