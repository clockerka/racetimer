import Foundation
enum Side: String, Codable, CaseIterable {
    case player1
    case player2
    var opposite: Side {
        switch self {
        case .player1: return .player2
        case .player2: return .player1
        }
    }
}
