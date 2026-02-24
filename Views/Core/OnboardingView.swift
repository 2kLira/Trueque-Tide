//
//  OnboardingView.swift
//  TruequeTide
//
//  Created by Guillermo Lira on 23/02/26.
//


import SwiftUI

struct OnboardingView: View {

    var onFinish: () -> Void

    @State private var stage = 0
    @State private var animateNetwork = false
    @State private var animateTrust = false

    var body: some View {

        ZStack {

            Color.backgroundSand.ignoresSafeArea()

            VStack(spacing: 40) {

                Spacer()

                content

                Spacer()

                if stage == 2 {
                    Button(action: onFinish) {
                        Text("Start Community →")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.oceanAccent)
                            .clipShape(Capsule())
                    }
                    .transition(.opacity)
                }
            }
            .padding(40)
        }
        .onTapGesture {
            nextStage()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                stage = 0
            }
        }
    }

    // MARK: Content by Stage

    @ViewBuilder
    private var content: some View {

        switch stage {

        case 0:
            VStack(spacing: 16) {
                Text("I grew up watching communities full of talent")
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)

                Text("with no real opportunity to grow.")
                    .foregroundColor(.oceanBase.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .transition(.opacity)

        case 1:
            VStack(spacing: 20) {

                Text("Value already exists inside communities.")
                    .font(.system(size: 22, weight: .medium))
                    .multilineTextAlignment(.center)

                Text("It just needs structure to circulate.")
                    .foregroundColor(.oceanBase.opacity(0.7))
                    .multilineTextAlignment(.center)

                SimpleNetworkView(animate: animateNetwork)
                    .frame(height: 180)
                    .padding(.top, 20)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    animateNetwork = true
                }
            }
            .transition(.opacity)

        default:
            VStack(spacing: 24) {

                Text("What if trust itself")
                    .font(.system(size: 24, weight: .medium))
                    .multilineTextAlignment(.center)

                Text("could become currency?")
                    .foregroundColor(.oceanBase.opacity(0.7))
                    .multilineTextAlignment(.center)

                TrustPreviewRing(animate: animateTrust)
                    .frame(width: 80, height: 80)
                    .padding(.top, 20)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    animateTrust = true
                }
            }
            .transition(.opacity)
        }
    }

    private func nextStage() {
        withAnimation(.easeInOut(duration: 0.6)) {
            if stage < 2 {
                stage += 1
            }
        }
    }
}
struct SimpleNetworkView: View {

    var animate: Bool

    var body: some View {

        GeometryReader { geo in

            let center = CGPoint(
                x: geo.size.width / 2,
                y: geo.size.height / 2
            )

            ZStack {

                Circle()
                    .fill(Color.oceanBase)
                    .frame(width: 20)
                    .position(center)

                Circle()
                    .fill(Color.oceanBase)
                    .frame(width: 16)
                    .position(x: center.x - 60, y: center.y + 30)

                Circle()
                    .fill(Color.oceanBase)
                    .frame(width: 16)
                    .position(x: center.x + 60, y: center.y - 20)

                Path { p in
                    p.move(to: center)
                    p.addLine(to: CGPoint(x: center.x - 60, y: center.y + 30))
                    p.move(to: center)
                    p.addLine(to: CGPoint(x: center.x + 60, y: center.y - 20))
                }
                .stroke(
                    Color.oceanAccent.opacity(animate ? 0.6 : 0.0),
                    lineWidth: 2
                )
                .animation(.easeInOut(duration: 1.2), value: animate)
            }
        }
    }
}
struct TrustPreviewRing: View {

    var animate: Bool

    var body: some View {

        ZStack {

            Circle()
                .stroke(Color.oceanBase.opacity(0.15), lineWidth: 6)

            Circle()
                .trim(from: 0, to: animate ? 0.65 : 0)
                .stroke(
                    Color.oceanAccent,
                    style: StrokeStyle(
                        lineWidth: 6,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.2), value: animate)
        }
    }
}
