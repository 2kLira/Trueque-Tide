//
//  CommunityNetworkView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 23/02/26.
//


//
//  CommunityNetworkView.swift
//  TruequeTide
//

import SwiftUI

struct CommunityNetworkView: View {

    @ObservedObject var store: TruequeStore

    @State private var animatePulse = false
    @State private var lastLedgerCount = 0

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [Color.backgroundSand.opacity(0.9), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 14) {

                headerMetrics

                GeometryReader { geo in

                    let size = geo.size
                    let users = store.selectedCommunity?.users ?? []
                    let positions = organicCirclePositions(users: users, in: size)
                    let connections = store.ledger

                    ZStack {

                        // Lines (under nodes)
                        ForEach(connections) { e in
                            if let p1 = positions[e.fromUser], let p2 = positions[e.toUser] {
                                NetworkEdge(
                                    from: p1,
                                    to: p2,
                                    tokens: e.tokens,
                                    trust: store.communityTrust,
                                    pulse: animatePulse
                                )
                            }
                        }

                        // Nodes
                        ForEach(users) { u in
                            if let p = positions[u.id] {
                                NetworkNode(
                                    name: u.name,
                                    balance: u.tokenBalance,
                                    trust: store.communityTrust
                                )
                                .position(p)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onChange(of: store.ledger.count) { newCount in
                        if newCount > lastLedgerCount {
                            triggerPulse()
                        }
                        lastLedgerCount = newCount
                    }
                    .onAppear {
                        lastLedgerCount = store.ledger.count
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 12)

                Spacer(minLength: 8)
            }
        }
    }

    // MARK: - Header metrics

    private var headerMetrics: some View {

        VStack(spacing: 10) {

            HStack {
                Text("Community Network")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.oceanBase.opacity(0.85))

                Spacer()

                Text("\(Int(store.communityTrust * 100))% Trust")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.oceanAccent)
            }
            .padding(.horizontal)
            .padding(.top, 6)

            HStack(spacing: 12) {
                metricChip(title: "Exchanges", value: "\(store.totalExchanges)")
                metricChip(title: "Circulated", value: "\(store.totalCirculated) TT")
                metricChip(title: "People", value: "\(store.selectedCommunity?.users.count ?? 0)")
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 4)
    }

    private func metricChip(title: String, value: String) -> some View {

        VStack(alignment: .leading, spacing: 4) {

            Text(value)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.oceanBase)

            Text(title)
                .font(.caption2)
                .foregroundColor(.oceanBase.opacity(0.55))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.glassBorder, lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
    }

    // MARK: - Organic circle positions (deterministic)

    private func organicCirclePositions(users: [User], in size: CGSize) -> [UUID: CGPoint] {

        let n = max(users.count, 1)
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.52)

        let baseRadius = min(size.width, size.height) * 0.34
        let angleStep = (2 * Double.pi) / Double(n)

        var dict: [UUID: CGPoint] = [:]

        for (i, u) in users.enumerated() {

            let h = stableHash(u.id.uuidString)

            let angleJitter = map01ToRange(h.a, -0.11, 0.11)
            let radiusJitterFactor = map01ToRange(h.b, -0.14, 0.14)

            let angle = (Double(i) * angleStep) + angleJitter
            let radius = baseRadius * (1.0 + radiusJitterFactor)

            let x = center.x + CGFloat(cos(angle)) * radius
            let y = center.y + CGFloat(sin(angle)) * radius

            dict[u.id] = CGPoint(x: x, y: y)
        }

        return dict
    }

    private func triggerPulse() {
        animatePulse = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            animatePulse = false
        }
    }

    // MARK: - Deterministic hash helpers

    private struct HashPair {
        let a: Double // 0..1
        let b: Double // 0..1
    }

    private func stableHash(_ s: String) -> HashPair {

        var total1: UInt64 = 0
        var total2: UInt64 = 1469598103934665603

        for scalar in s.unicodeScalars {
            total1 &+= UInt64(scalar.value) * 1315423911
            total2 ^= UInt64(scalar.value)
            total2 &*= 1099511628211
        }

        let a = Double(total1 % 10_000) / 10_000.0
        let b = Double(total2 % 10_000) / 10_000.0
        return HashPair(a: a, b: b)
    }

    private func map01ToRange(_ x: Double, _ minV: Double, _ maxV: Double) -> Double {
        minV + (maxV - minV) * x
    }
}

// MARK: - Edge

private struct NetworkEdge: View {

    let from: CGPoint
    let to: CGPoint
    let tokens: Int
    let trust: Double
    let pulse: Bool

    var body: some View {

        Path { p in
            p.move(to: from)
            p.addLine(to: to)
        }
        .stroke(
            Color.oceanAccent.opacity(edgeOpacity),
            style: StrokeStyle(
                lineWidth: edgeWidth,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .shadow(
            color: Color.oceanAccent.opacity(pulse ? 0.18 : 0.06),
            radius: pulse ? 10 : 6
        )
        .animation(.spring(response: 0.35, dampingFraction: 0.75), value: pulse)
    }

    private var edgeWidth: CGFloat {
        let w = 1.2 + CGFloat(min(tokens, 12)) * 0.25
        return min(w, 5.0)
    }

    private var edgeOpacity: Double {
        0.18 + trust * 0.37
    }
}

// MARK: - Node

private struct NetworkNode: View {

    let name: String
    let balance: Int
    let trust: Double

    var body: some View {

        VStack(spacing: 6) {

            Text(name)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.oceanBase)

            Text("\(balance) TT")
                .font(.caption2)
                .foregroundColor(.oceanBase.opacity(0.6))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.glassBorder, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 8)
        .scaleEffect(nodeScale)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: trust)
    }

    private var nodeScale: CGFloat {
        let s = 0.98 + CGFloat(trust) * 0.04
        return min(max(s, 0.98), 1.02)
    }
}
