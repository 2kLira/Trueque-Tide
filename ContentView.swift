//
//  ContentView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI

struct ContentView: View {

    @StateObject var store = TruequeStore()

    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    @State private var showStory = true

    var body: some View {

        NavigationStack {

            if !hasSeenOnboarding {

                OnboardingView {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        hasSeenOnboarding = true
                    }
                }

            } else if showStory {

                EconomicSimulationView {
                    withAnimation {
                        showStory = false
                    }
                }

            } else if store.selectedCommunity == nil || store.selectedUser == nil {

                SelectionView(store: store)

            } else {

                MainTabsView(store: store) {
                    store.reset()
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: hasSeenOnboarding)
    }
}
