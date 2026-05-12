import Foundation
struct Round: Codable, Identifiable {
    let id: UUID
    var scramble: SideMap<String>
    var solves: SideMap<Solve?>
    var winner: Side?
    init(id: UUID = UUID(), scramble: SideMap<String> = SideMap(player1: "", player2: ""), solves: SideMap<Solve?> = SideMap(player1: nil, player2: nil), winner: Side? = nil) {
        self.id = id
        self.scramble = scramble
        self.solves = solves
        self.winner = winner
    }
    static func determineWinner(_ round: Round) -> Side? {
        guard let solve1 = round.solves.player1,
              let solve2 = round.solves.player2,
              let time1 = solve1.effectiveTime,
              let time2 = solve2.effectiveTime else {
            if round.solves.player1?.penalty == .dnf && round.solves.player2?.effectiveTime != nil {
                return .player2
            }
            if round.solves.player2?.penalty == .dnf && round.solves.player1?.effectiveTime != nil {
                return .player1
            }
            return nil
        }
        return time1 < time2 ? .player1 : .player2
    }
}
