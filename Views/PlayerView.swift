import SwiftUI
struct PlayerView: View {
    let side: Side
    @EnvironmentObject var raceContext: RaceContext
    @StateObject private var timerMachine = TimerMachine()
    @State private var showStats = false
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(spacing: 12) {
                    Text(scoreText)
                        .font(.system(size: 28, weight: .regular))
                        .foregroundColor(.accentColor)
                        .padding(.top, max(geometry.safeAreaInsets.top, 12))
                    Text(scrambleText)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                        .frame(minHeight: 50)
                    Spacer()
                    TimerArea(
                        timerMachine: timerMachine,
                        timerText: timerText,
                        timerColor: timerColor,
                        timerTextColor: timerTextColor
                    )
                    Spacer()
                    Color.clear
                        .frame(height: 48 + max(geometry.safeAreaInsets.bottom, 0))
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color(UIColor.systemBackground))
                VStack(spacing: 0) {
                    if showStats && !raceContext.roundStarted {
                        StatsView(side: side)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showStats.toggle()
                        }
                    }) {
                        HStack {
                            Text(LocalizedString.stats.localized)
                                .font(.system(size: 14, weight: .bold))
                                .textCase(.uppercase)
                            Image(systemName: showStats ? "chevron.down" : "chevron.up")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .padding(.bottom, max(geometry.safeAreaInsets.bottom, 0))
                        .background(Color(UIColor.secondarySystemBackground))
                    }
                    .disabled(raceContext.roundStarted)
                }
                .padding(.bottom, side == .player2 ? max(geometry.safeAreaInsets.top, 12) + 50 : 0)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            setupTimerCallbacks()
        }
        .onChange(of: raceContext.roundStarted) { newValue in
            if !newValue {
                timerMachine.unblock()
            }
        }
    }
    private var scoreText: String {
        let myScore = raceContext.score[side]
        let opponentScore = raceContext.score[side.opposite]
        return "\(myScore) : \(opponentScore)"
    }
    private var scrambleText: String {
        if !raceContext.session.generateScrambles {
            return LocalizedString.handScramble.localized
        } else if raceContext.scramblesGenerating {
            return LocalizedString.generating.localized
        } else {
            return raceContext.currentRound.scramble[side]
        }
    }
    private var timerText: String {
        switch timerMachine.state {
        case .ready:
            if let prevSolve = raceContext.previousRound?.solves[side] {
                return prevSolve.displayTime
            }
            return "0.00"
        case .waiting:
            return "0.00"
        case .standby:
            return LocalizedString.ready.localized
        case .running:
            return formatTime(timerMachine.elapsedTimeMs)
        case .stopped, .blocked:
            return formatTime(timerMachine.elapsedTimeMs)
        }
    }
    private var timerColor: Color {
        switch timerMachine.state {
        case .ready:
            return Color(UIColor.systemBackground)
        case .waiting:
            return Color.red.opacity(0.3)
        case .standby:
            return Color.green.opacity(0.3)
        case .running:
            return Color(UIColor.systemBackground)
        case .stopped, .blocked:
            return Color(UIColor.systemBackground)
        }
    }
    private var timerTextColor: Color {
        switch timerMachine.state {
        case .ready:
            return Color.primary
        case .waiting, .blocked:
            return Color.red
        case .standby:
            return Color.green
        case .running:
            return Color.primary
        case .stopped:
            return Color.primary
        }
    }
    private func formatTime(_ ms: Int) -> String {
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
    private func setupTimerCallbacks() {
        timerMachine.onTimerStarted = { [weak raceContext] in
            raceContext?.roundStarted = true
        }
        timerMachine.onTimerStopped = { [weak raceContext, side] elapsedMs in
            raceContext?.recordSolve(side: side, timeMs: elapsedMs)
        }
    }
}
#Preview {
    PlayerView(side: .player1)
        .environmentObject(RaceContext())
}
