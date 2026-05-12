import Foundation
struct Solve: Codable, Identifiable {
    let id: UUID
    let timeMs: Int
    var penalty: Penalty?
    init(id: UUID = UUID(), timeMs: Int, penalty: Penalty? = nil) {
        self.id = id
        self.timeMs = timeMs
        self.penalty = penalty
    }
    var displayTime: String {
        if penalty == .dnf {
            return "DNF"
        }
        let adjustedTime = penalty == .plusTwo ? timeMs + 2000 : timeMs
        let formatted = formatDuration(adjustedTime)
        return penalty == .plusTwo ? "\(formatted)+" : formatted
    }
    var effectiveTime: Int? {
        if penalty == .dnf {
            return nil
        }
        return penalty == .plusTwo ? timeMs + 2000 : timeMs
    }
    private func formatDuration(_ ms: Int) -> String {
        let totalSeconds = Double(ms) / 1000.0
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        let milliseconds = Int((totalSeconds.truncatingRemainder(dividingBy: 1)) * 100)
        if minutes > 0 {
            return String(format: "%d:%02d.%02d", minutes, seconds, milliseconds)
        } else {
            return String(format: "%d.%02d", seconds, milliseconds)
        }
    }
}
