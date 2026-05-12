import SwiftUI
struct StatsView: View {
    let side: Side
    @EnvironmentObject var raceContext: RaceContext
    var body: some View {
        let stats = raceContext.session.stats[side].computedStats
        let totalSolves = raceContext.session.completedRounds.count
        let successfulSolves = raceContext.session.completedRounds.filter {
            $0.solves[side]?.penalty != .dnf
        }.count
        VStack(spacing: 12) {
            Divider()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    StatItem(label: LocalizedString.best.localized, value: formatStat(stats.best))
                    Spacer()
                    StatItem(label: LocalizedString.worst.localized, value: formatStat(stats.worst))
                }
                HStack {
                    StatItem(label: LocalizedString.mean.localized, value: formatStat(stats.mean))
                    Spacer()
                    StatItem(label: LocalizedString.ao5.localized, value: formatStat(stats.ao5))
                }
                HStack {
                    StatItem(label: LocalizedString.ao12.localized, value: formatStat(stats.ao12))
                    Spacer()
                    StatItem(label: "solves", value: "\(successfulSolves)/\(totalSolves)")
                }
            }
            .padding(.horizontal)
            NavigationLink(destination: SolvesView(showCloseButton: false)) {
                Text(LocalizedString.solves.localized)
                    .font(.system(size: 14))
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
        .background(Color(UIColor.secondarySystemBackground))
    }
    private func formatStat(_ ms: Int?) -> String {
        guard let ms = ms else { return "-" }
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
struct StatItem: View {
    let label: String
    let value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            Text(value)
                .font(.system(size: 16, weight: .regular, design: .monospaced))
        }
    }
}
#Preview {
    StatsView(side: .player1)
        .environmentObject(RaceContext())
}
