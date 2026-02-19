//
//  DashboardView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI
import UIKit

struct DashboardView: View {
    
    @ObservedObject var store: TruequeStore
    var community: Community
    var user: User
    var reset: () -> Void
    
    @State private var counterTrueque: Trueque?
    @State private var showAddSheet = false
    
    var body: some View {
        
        VStack {
            
            header
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    ForEach(community.trueques) { trueque in
                        
                        TruequeCard(
                            trueque: trueque,
                            currentUser: user.name,
                            onAccept: {
                                updateStatus(trueque, .accepted)
                            },
                            onReject: {
                                updateStatus(trueque, .rejected)
                            },
                            onCounter: {
                                counterTrueque = trueque
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddTruequeView(store: store)
        }
        .sheet(item: $counterTrueque) { trueque in
            
            CounterOfferView(trueque: trueque) { newValue in
                applyCounter(trueque, newValue)
            }
        }
    }
    
    private var header: some View {
        HStack {
            
            Button {
                reset()
            } label: {
                Image(systemName: "chevron.left")
            }
            
            Spacer()
            
            Text("TRUEQUE TIDE")
            
            Spacer()
            
            Button {
                showAddSheet = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .padding()
    }
    
    private func updateStatus(_ trueque: Trueque, _ newStatus: TruequeStatus) {
        
        if let index = store.selectedCommunity?.trueques.firstIndex(where: { $0.id == trueque.id }) {
            store.selectedCommunity?.trueques[index].status = newStatus
        }
    }
    
    private func applyCounter(_ trueque: Trueque, _ newValue: Int) {
        
        if let index = store.selectedCommunity?.trueques.firstIndex(where: { $0.id == trueque.id }) {
            
            store.selectedCommunity?.trueques[index].tokens = newValue
            store.selectedCommunity?.trueques[index].status = .countered
            store.selectedCommunity?.trueques[index].lastCounterBy = user.name
        }
    }
}
