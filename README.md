# Equil App – Unified Wellness Tracker

> Comprehensive Swift-based wellness application for mental & physical health

![Swift](https://img.shields.io/badge/language-Swift-orange)
![Build](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-see%20LICENSE-lightgrey)

## What the Project Does

**Equil** is a wellness app that unifies physical and mental health tracking for iPhone and iPad. Unlike most wellness apps which fragment your routines across multiple platforms, Equil brings workouts, journaling, mindfulness, hydration, and nutrition together in one cohesive interface.

## Why the Project Is Useful

- **All-in-One Wellness:** Log workouts, track mental health, and review progress in one place.
- **Habit Formation:** Designed to help users build long-term healthy habits without switching between apps.
- **Flexible for Everyone:** Supports both beginners with simple routines and experienced athletes with customizable, detailed tracking.

## Key Features

- **Physical Activity Logging:** Track workouts, completed sessions, and personal records
- **Mood & Journal Tracker:** Log thoughts, feelings, and reflections to form connections between activities and wellbeing
- **Customizable Workouts:** Add or remove categories, track total time, and monitor trends
- **Mindfulness Tools:** One-minute breathing exercises available
- **Progress Summaries:** Overview screens and summaries to visualize habits and see changes over time
- **Reminders & Daily Check-ins:** Stay motivated, build consistency
- **Multi-Device Compatibility:** Works seamlessly on iPhone and iPad
- **Authentication:** Secure login with username/password and optional simulated Face ID
- **Reliable Data Storage:** Persistent, private tracking of user information

## How Users Can Get Started

### Prerequisites

- **macOS** with [Xcode](https://developer.apple.com/xcode/) (Latest recommended)
- Swift toolchain

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/siabn4/3714finalgroupproject.git
   cd 3714finalgroupproject
   ```

2. **Open the Project**
   - Open `3714finalgroupproject.xcodeproj` in Xcode.

3. **Build and Run**
   - Click "Run" in Xcode or use `Cmd + R` to launch Equil on simulator or device.

### Usage Example

```swift
// Example: SwiftUI Main Entry Point
import SwiftUI

@main
struct loginApp: App {
    @StateObject var taskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(taskViewModel)
        }
    }
}
```
Try out logging a workout, journaling your mood, reviewing your activity summary, or starting a mindfulness breathing exercise through the app's dashboard.

## Where Users Can Get Help

- [Issue Tracker](https://github.com/siabn4/3714finalgroupproject/issues): Report bugs or request enhancements
- SwiftUI Documentation: [Swift.org Documentation](https://swift.org/documentation/)
- Refer to in-app onboarding and help screens

If you have additional questions, open an issue or check out discussions with other contributors.

## Who Maintains and Contributes

- **Authors / Maintainers:** Brendan Nave ([brendnav](https://github.com/BrendNav)), Saveer Pande ([spande102](https://github.com/Spande102)), Sindhu Bonagiri ([siabn4](https://github.com/siabn4))
- Want to contribute? See [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) for guidelines.

We welcome feedback and pull requests to continue improving Equil!

---

For license information, see [`LICENSE`](LICENSE).
