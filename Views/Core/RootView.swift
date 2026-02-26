//
//  RootView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 23/02/26.
//

import SwiftUI

struct RootView: View {

    @StateObject private var store = TruequeStore()
    @State private var showOnboarding = true
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {

        Group {

            if showOnboarding {

                OnboardingView {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        showOnboarding = false
                    }
                }
                .transition(.opacity)

            } else {

                if sizeClass == .regular {
                    ipadContainer
                } else {
                    iphoneContainer
                }

            }
        }
        .animation(.easeInOut(duration: 0.6), value: showOnboarding)
    }
}

// MARK: - Containers

extension RootView {

    // iPad uses full width environment
    private var ipadContainer: some View {

        MainTabsView(store: store) {
            store.reset()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundSand)
    }

    // iPhone standard container
    private var iphoneContainer: some View {

        MainTabsView(store: store) {
            store.reset()
        }
        .transition(.opacity)
    }
}
