//
//  TruequeCard.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI

struct TruequeCard: View {
    
    var title: String
    var description: String
    var tokens: Int
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.subheadline)
            
            Text("\(tokens) TT")
                .foregroundColor(.blue)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
}
