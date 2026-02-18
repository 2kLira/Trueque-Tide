//
//  SelectionView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI

struct SelectionView: View {
    
    @ObservedObject var store: TruequeStore
    
    @State private var showCommunities = false
    @State private var showUsers = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [
                    Color.backgroundSand,
                    Color.white.opacity(0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 60) {
                
                Spacer()
                
                Text("TRUEQUE TIDE")
                    .font(.system(size: 22, weight: .medium))
                    .tracking(6)
                    .foregroundColor(.oceanBase)
                
                // COMMUNITY
                
                VStack(spacing: 8) {
                    s
                    Button {
                        showCommunities = true
                    } label: {
                        Text("🌐")
                            .font(.system(size: store.selectedCommunity == nil ? 95 : 55))
                            .animation(.easeInOut(duration: 0.3), value: store.selectedCommunity != nil)
                    }
                    
                    Text("Community")
                        .font(.caption)
                        .foregroundColor(.oceanBase)
                }
                
                // USER
                
                VStack(spacing: 8) {
                    
                    Button {
                        if store.selectedCommunity != nil {
                            showUsers = true
                        }
                    } label: {
                        Text("👤")
                            .font(.system(size: store.selectedCommunity != nil && store.selectedUser == nil ? 95 : 55))
                            .foregroundColor(
                                store.selectedCommunity == nil ?
                                .gray.opacity(0.4) :
                                .oceanAccent
                            )
                            .animation(.easeInOut(duration: 0.3), value: store.selectedUser != nil)
                    }
                    
                    Text("User")
                        .font(.caption)
                        .foregroundColor(.oceanBase)
                }
                
                Spacer()
            }
        }
        
        // MARK: Community Sheet
        
        .sheet(isPresented: $showCommunities) {
            
            NavigationView {
                
                List(store.communities) { community in
                    Button(community.name) {
                        store.selectCommunity(community)
                        showCommunities = false
                    }
                }
                .navigationTitle("Select Community")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Back") {
                            showCommunities = false
                        }
                    }
                }
            }
        }
        
        // MARK: User Sheet
        
        .sheet(isPresented: $showUsers) {
            
            NavigationView {
                
                List(store.selectedCommunity?.users ?? []) { user in
                    Button(user.name) {
                        store.selectUser(user)
                        showUsers = false
                    }
                }
                .navigationTitle("Select User")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Back") {
                            showUsers = false
                        }
                    }
                }
            }
        }
    }
}
