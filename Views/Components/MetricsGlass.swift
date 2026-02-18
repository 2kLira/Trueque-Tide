//
//  MetricsGlass.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 17/02/26.
//


import SwiftUI

struct MetricsGlass: View {

    @ObservedObject var engine: SimulationEngine

    var body: some View {

        let m = engine.metrics

        HStack(spacing: 18) {

            MetricPill(title: "Exchanges", value: "\(m.exchanges)")
            MetricPill(title: "Circulated", value: "\(Int(m.circulated)) TT")
            MetricPill(title: "Trust", value: "\(Int(m.trustIndex * 100))%")
        }
        .padding(18)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.glassBorder, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

private struct MetricPill: View {

    var title: String
    var value: String

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.oceanBase)

            Text(title)
                .font(.caption)
                .foregroundColor(.oceanBase.opacity(0.55))
        }
        .frame(maxWidth: .infinity)
    }
}
