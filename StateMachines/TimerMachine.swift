import Foundation
import Combine
enum TimerState {
    case ready
    case waiting
    case standby
    case running
    case stopped
    case blocked
}
class TimerMachine: ObservableObject {
    @Published var state: TimerState = .ready
    @Published var elapsedTimeMs: Int = 0
    private var startDate: Date?
    private var timer: Timer?
    private var waitTimer: Timer?
    private let timerDelaySeconds: TimeInterval = 0.3
    private let timerTickMs: Int = 10
    var onTimerStarted: (() -> Void)?
    var onTimerStopped: ((Int) -> Void)?
    func handsDown() {
        switch state {
        case .ready:
            state = .waiting
            startWaitTimer()
        case .standby:
            break
        case .running:
            stopTimer()
            state = .stopped
            onTimerStopped?(elapsedTimeMs)
        case .stopped:
            state = .blocked
        default:
            break
        }
    }
    func handsUp() {
        switch state {
        case .waiting:
            cancelWaitTimer()
            state = .ready
        case .standby:
            startTimer()
            state = .running
            onTimerStarted?()
        case .blocked:
            state = .stopped
        default:
            break
        }
    }
    func unblock() {
        if state == .stopped || state == .blocked {
            state = .ready
            elapsedTimeMs = 0
        }
    }
    private func startWaitTimer() {
        waitTimer = Timer.scheduledTimer(withTimeInterval: timerDelaySeconds, repeats: false) { [weak self] _ in
            self?.state = .standby
        }
    }
    private func cancelWaitTimer() {
        waitTimer?.invalidate()
        waitTimer = nil
    }
    private func startTimer() {
        startDate = Date()
        elapsedTimeMs = 0
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timerTickMs) / 1000.0, repeats: true) { [weak self] _ in
            self?.updateElapsedTime()
        }
    }
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        updateElapsedTime()
    }
    private func updateElapsedTime() {
        guard let startDate = startDate else { return }
        let elapsed = Date().timeIntervalSince(startDate)
        elapsedTimeMs = Int(elapsed * 1000)
    }
    deinit {
        timer?.invalidate()
        waitTimer?.invalidate()
    }
}
