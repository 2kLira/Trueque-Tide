//
//  RootView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 23/02/26.
//


import SwiftUI

struct RootView: View {

    @StateObject private var store = TruequeStore()
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {

        ZStack {

            if hasSeenOnboarding {
                MainTabsView(store: store) {
                    store.reset()
                }
                .transition(.opacity)
            } else {
                OnboardingView {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        hasSeenOnboarding = true
                    }
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: hasSeenOnboarding)
    }
}