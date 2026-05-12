import Foundation
import Combine
class RaceContext: ObservableObject {
    @Published var session: Session
    @Published var currentRound: Round
    @Published var previousRound: Round?
    @Published var roundStarted: Bool = false
    @Published var scramblesGenerating: Bool = false
    private let storageKey = "currentSessionId"
    private let sessionPrefix = "session_"
    init() {
        if let sessionId = UserDefaults.standard.string(forKey: storageKey),
           let loadedSession = Self.loadSession(id: sessionId) {
            self.session = loadedSession
            if let lastRound = loadedSession.completedRounds.last {
                self.previousRound = lastRound
            }
        } else {
            self.session = Session()
        }
        self.currentRound = Round()
        DispatchQueue.main.async { [weak self] in
            self?.saveSession()
            self?.generateScrambles()
        }
    }
    var score: SideMap<Int> {
        session.score
    }
    func recordSolve(side: Side, timeMs: Int) {
        let solve = Solve(timeMs: timeMs)
        currentRound.solves[side] = solve
        session.stats[side].addSolve(solve)
        if currentRound.solves.player1 != nil && currentRound.solves.player2 != nil {
            concludeRound()
            startNewRound()
        }
    }
    func concludeRound() {
        currentRound.winner = Round.determineWinner(currentRound)
        previousRound = currentRound
        session.completedRounds.append(currentRound)
        saveSession()
    }
    func startNewRound() {
        currentRound = Round()
        roundStarted = false
        generateScrambles()
    }
    func setPenalty(side: Side, penalty: Penalty?) {
        guard var prevRound = previousRound,
              var solve = prevRound.solves[side] else { return }
        solve.penalty = penalty
        prevRound.solves[side] = solve
        prevRound.winner = Round.determineWinner(prevRound)
        if let index = session.completedRounds.firstIndex(where: { $0.id == prevRound.id }) {
            session.completedRounds[index] = prevRound
        }
        session.stats[side].replaceLastSolve(solve)
        previousRound = prevRound
        saveSession()
    }
    func generateScrambles() {
        scramblesGenerating = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if !self.session.generateScrambles {
                DispatchQueue.main.async {
                    self.scramblesGenerating = false
                }
                return
            }
            let event1 = self.session.selectedEvents.player1
            let event2 = self.session.selectedEvents.player2
            if event1.eventId == event2.eventId {
                let scramble = ScrambleGenerator.generateScramble(for: event1.eventId)
                DispatchQueue.main.async {
                    self.currentRound.scramble.player1 = scramble
                    self.currentRound.scramble.player2 = scramble
                    self.scramblesGenerating = false
                }
            } else {
                let scramble1 = ScrambleGenerator.generateScramble(for: event1.eventId)
                let scramble2 = ScrambleGenerator.generateScramble(for: event2.eventId)
                DispatchQueue.main.async {
                    self.currentRound.scramble.player1 = scramble1
                    self.currentRound.scramble.player2 = scramble2
                    self.scramblesGenerating = false
                }
            }
        }
    }
    func startNewSession(name: String? = nil, playerNames: SideMap<String?>, selectedEvents: SideMap<Event>, generateScrambles: Bool) {
        let newSession = Session(
            name: name,
            playerNames: playerNames,
            selectedEvents: selectedEvents,
            generateScrambles: generateScrambles
        )
        self.session = newSession
        self.previousRound = nil
        self.currentRound = Round()
        saveSession()
        self.generateScrambles()
    }
    private func saveSession() {
        UserDefaults.standard.set(session.id.uuidString, forKey: storageKey)
        if let encoded = try? JSONEncoder().encode(session) {
            UserDefaults.standard.set(encoded, forKey: sessionPrefix + session.id.uuidString)
        }
    }
    private static func loadSession(id: String) -> Session? {
        guard let data = UserDefaults.standard.data(forKey: "session_" + id),
              let session = try? JSONDecoder().decode(Session.self, from: data) else {
            return nil
        }
        return session
    }
    func getAllSessions() -> [Session] {
        let defaults = UserDefaults.standard
        let allKeys = defaults.dictionaryRepresentation().keys
        return allKeys
            .filter { $0.hasPrefix(sessionPrefix) }
            .compactMap { key in
                guard let data = defaults.data(forKey: key),
                      let session = try? JSONDecoder().decode(Session.self, from: data) else {
                    return nil
                }
                return session
            }
            .sorted { $0.createdDate > $1.createdDate }
    }
    func selectSession(id: UUID) {
        if let loadedSession = Self.loadSession(id: id.uuidString) {
            self.session = loadedSession
            self.previousRound = loadedSession.completedRounds.last
            self.currentRound = Round()
            UserDefaults.standard.set(id.uuidString, forKey: storageKey)
            generateScrambles()
        }
    }
    func deleteSession(id: UUID) {
        UserDefaults.standard.removeObject(forKey: sessionPrefix + id.uuidString)
        if session.id == id {
            let newSession = Session()
            self.session = newSession
            self.previousRound = nil
            self.currentRound = Round()
            saveSession()
            generateScrambles()
        }
    }
    func changeEvent(side: Side, newEvent: Event) {
        session.selectedEvents[side] = newEvent
        saveSession()
        generateScrambles()
    }
}
