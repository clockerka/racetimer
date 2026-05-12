import Foundation
struct Session: Codable, Identifiable {
    var id: UUID
    var name: String?
    var playerNames: SideMap<String?>
    var createdDate: Date
    var selectedEvents: SideMap<Event>
    var generateScrambles: Bool
    var completedRounds: [Round]
    var stats: SideMap<StatsContext>
    init(
        id: UUID = UUID(),
        name: String? = nil,
        playerNames: SideMap<String?> = SideMap(player1: nil, player2: nil),
        createdDate: Date = Date(),
        selectedEvents: SideMap<Event> = SideMap(
            player1: Event.getEvent(byId: "333"),
            player2: Event.getEvent(byId: "333")
        ),
        generateScrambles: Bool = true,
        completedRounds: [Round] = [],
        stats: SideMap<StatsContext> = SideMap(player1: StatsContext(), player2: StatsContext())
    ) {
        self.id = id
        self.name = name
        self.playerNames = playerNames
        self.createdDate = createdDate
        self.selectedEvents = selectedEvents
        self.generateScrambles = generateScrambles
        self.completedRounds = completedRounds
        self.stats = stats
    }
    var score: SideMap<Int> {
        let player1Score = completedRounds.filter { $0.winner == .player1 }.count
        let player2Score = completedRounds.filter { $0.winner == .player2 }.count
        return SideMap(player1: player1Score, player2: player2Score)
    }
}
