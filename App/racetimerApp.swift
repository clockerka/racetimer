import SwiftUI
@main
struct racetimerApp: App {
    @StateObject private var raceContext = RaceContext()
    var body: some Scene {
        WindowGroup {
            TimerView()
                .environmentObject(raceContext)
        }
    }
}
