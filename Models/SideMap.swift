import Foundation
struct SideMap<T: Codable>: Codable {
    var player1: T
    var player2: T
    subscript(side: Side) -> T {
        get {
            switch side {
            case .player1: return player1
            case .player2: return player2
            }
        }
        set {
            switch side {
            case .player1: player1 = newValue
            case .player2: player2 = newValue
            }
        }
    }
}
