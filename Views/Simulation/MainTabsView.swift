//
//  MainTabsView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 23/02/26.
//


import SwiftUI

struct MainTabsView: View {

    @ObservedObject var store: TruequeStore
    var reset: () -> Void

    var body: some View {

        TabView {

            DashboardView(store: store, reset: reset)
                .tabItem {
                    Image(systemName: "hand.raised.fill")
                    Text("Favores")
                }

            CommunityNetworkView(store: store)
                .tabItem {
                    Image(systemName: "network")
                    Text("Red")
                }
        }
    }
}
