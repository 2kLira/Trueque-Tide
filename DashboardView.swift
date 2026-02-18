//
//  DashboardView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var store: TruequeStore
    
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
            
            VStack {
                
                // TOP BAR
                
                HStack {
                    
                    Button {
                        store.reset()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.oceanBase)
                    }
                    
                    Spacer()
                    
                    Button {
                        store.addTrueque(
                            title: "Community Support",
                            description: "Assist with shared work",
                            tokens: 3
                        )
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.oceanBase)
                    }
                }
                .padding()
                
                Text("TRUEQUE TIDE")
                    .font(.system(size: 20, weight: .medium))
                    .tracking(5)
                    .foregroundColor(.oceanBase)
                
                Spacer()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        ForEach(store.selectedCommunity?.trueques ?? []) { trueque in
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(trueque.title)
                                    .font(.headline)
                                
                                Text(trueque.description)
                                    .font(.subheadline)
                                
                                Text("\(trueque.tokens) TT")
                                    .foregroundColor(.oceanAccent)
                                
                                Text("By \(trueque.owner)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.6))
                            )
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}
