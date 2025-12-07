//
//  MeditationView.swift
//  WorkoutTrackerApp
//
//  Created by Saveer Pande on 12/7/25.
//

import SwiftUI

struct MeditationView: View {
    @State private var isBreathing = false
    @State private var timeRemaining = 60
    @State private var circleScale: CGFloat = 1.0
    @State private var timer: Timer? = nil

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 40) {
                
                Text("1-Minute Breathing")
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                // MARK: - Animated Breathing Circle
                ZStack {
                    Circle()
                        .fill(Color.cyan.opacity(0.3))
                        .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                        .scaleEffect(circleScale)
                        .animation(
                            .easeInOut(duration: 4)
                                .repeatForever(autoreverses: true),
                            value: circleScale
                        )

                    Text("\(timeRemaining)s")
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                Text(isBreathing ? "Inhale... Exhale..." : "Tap Start to begin")
                    .font(.headline)
                    .foregroundColor(.gray)

                // MARK: - Buttons
                HStack(spacing: 20) {
                    Button(action: startBreathing) {
                        Text("Start")
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 120)
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(isBreathing)

                    Button(action: resetBreathing) {
                        Text("Reset")
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 120)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .padding()
        }
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        .onDisappear { timer?.invalidate() }
    }

    // MARK: - Logic
    func startBreathing() {
        guard !isBreathing else { return }
        isBreathing = true
        timeRemaining = 60
        circleScale = 1.4

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                resetBreathing()
            }
        }
    }

    func resetBreathing() {
        timer?.invalidate()
        timer = nil
        isBreathing = false
        timeRemaining = 60
        circleScale = 1.0
    }
}


#Preview {
    MeditationView()
}
