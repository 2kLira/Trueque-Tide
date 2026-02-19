//
//  TruequeCard.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI
import UIKit

struct TruequeCard: View {
    
    var trueque: Trueque
    var currentUser: String
    
    var onAccept: () -> Void
    var onReject: () -> Void
    var onCounter: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(trueque.title)
                        .font(.headline)
                    
                    Text(trueque.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("\(trueque.tokens) TT")
                    .font(.subheadline)
                    .foregroundColor(.oceanAccent)
                    .animation(.easeInOut(duration: 0.25), value: trueque.tokens)
            }
            
            statusSection
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 8)
        .animation(.easeInOut(duration: 0.3), value: trueque.status)
    }
    
    private var backgroundColor: Color {
        switch trueque.status {
        case .countered:
            return Color.orange.opacity(0.1)
        default:
            return Color.white
        }
    }
    
    @ViewBuilder
    private var statusSection: some View {
        
        if trueque.owner == currentUser {
            
            HStack {
                Text("Your Trueque")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                statusBadge
            }
            
        } else {
            
            switch trueque.status {
                
            case .active:
                HStack {
                    Button("Accept") { onAccept() }
                    Spacer()
                    Button("Counter") { onCounter() }
                    Spacer()
                    Button("Reject") { onReject() }
                }
                .font(.caption)
                
            case .countered:
                HStack {
                    statusBadge
                    Spacer()
                    Button("Accept") { onAccept() }
                    Spacer()
                    Button("Reject") { onReject() }
                }
                .font(.caption)
                
            case .accepted, .rejected:
                statusBadge
            }
        }
    }
    
    private var statusBadge: some View {
        
        Group {
            switch trueque.status {
                
            case .countered:
                if trueque.lastCounterBy == currentUser {
                    Text("You countered")
                        .foregroundColor(.orange)
                } else {
                    Text("Countered")
                        .foregroundColor(.orange)
                }
                
            case .accepted:
                Text("Accepted")
                    .foregroundColor(.green)
                
            case .rejected:
                Text("Rejected")
                    .foregroundColor(.red)
                
            default:
                EmptyView()
            }
        }
        .font(.caption)
    }
}
