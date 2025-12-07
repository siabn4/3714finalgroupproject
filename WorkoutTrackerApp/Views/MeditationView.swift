//
//  MeditationView.swift
//  WorkoutTrackerApp
//
//  Created by Saveer Pande on 12/7/25.
//

import SwiftUI

// MeditationView provides a simple 1-minute guided breathing UI with an animated circle.
// - Tapping Start starts a 60s countdown and begins an in/out scale animation.
// - Reset stops and resets the timer and animation state.
struct MeditationView: View {
    // Controls whether the breathing session is active
    @State private var isBreathing = false

    // Countdown time remaining (seconds)
    @State private var timeRemaining = 60

    // Scale effect applied to the circle to simulate inhale/exhale
    @State private var circleScale: CGFloat = 1.0

    // Timer instance used to decrement timeRemaining every second
    @State private var timer: Timer? = nil

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 40) {

                Text("1-Minute Breathing")
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                // MARK: - Animated Breathing Circle
                // Circle scales between 1.0 and 1.4 to represent inhale/exhale.
                ZStack {
                    Circle()
                        .fill(Color.cyan.opacity(0.3))
                        .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                        .scaleEffect(circleScale)
                        .animation(
                            // Smooth ease in/out animation repeated forever while circleScale changes.
                            .easeInOut(duration: 4)
                                .repeatForever(autoreverses: true),
                            value: circleScale
                        )

                    // Remaining time displayed at the center of the circle.
                    Text("\(timeRemaining)s")
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                // Instructional / status text
                Text(isBreathing ? "Inhale... Exhale..." : "Tap Start to begin")
                    .font(.headline)
                    .foregroundColor(.gray)

                // MARK: - Buttons
                HStack(spacing: 20) {
                    // Start button disables while breathing is active
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

                    // Reset button cancels any active timer and returns UI to default state.
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
        // Light background for the breathing screen
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        // Ensure timer is invalidated when the view disappears (cleanup).
        .onDisappear { timer?.invalidate() }
    }

    // MARK: - Logic

    // Starts the breathing session:
    //  - Sets isBreathing to true
    //  - Sets the countdown to 60 seconds
    //  - Triggers the circle scale to expand and begin animation
    //  - Schedules a Timer to reduce timeRemaining once per second
    func startBreathing() {
        guard !isBreathing else { return }
        isBreathing = true
        timeRemaining = 60
        circleScale = 1.4

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // When countdown reaches zero, reset breathing state.
                resetBreathing()
            }
        }
    }

    // Stops any running timer and resets UI state to initial values.
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
