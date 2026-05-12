import Foundation
class ScrambleGenerator {
    static func generate333Scramble() -> String {
        let moves = ["R", "L", "U", "D", "F", "B"]
        let modifiers = ["", "'", "2"]
        var scramble: [String] = []
        var lastMove = ""
        var beforeLastMove = ""
        for _ in 0..<20 {
            var move: String
            repeat {
                move = moves.randomElement()!
            } while move == lastMove || (move == beforeLastMove && areSameFace(move, lastMove))
            let modifier = modifiers.randomElement()!
            scramble.append(move + modifier)
            beforeLastMove = lastMove
            lastMove = move
        }
        return scramble.joined(separator: " ")
    }
    static func generate222Scramble() -> String {
        let moves = ["R", "U", "F"]
        let modifiers = ["", "'", "2"]
        var scramble: [String] = []
        var lastMove = ""
        for _ in 0..<9 {
            var move: String
            repeat {
                move = moves.randomElement()!
            } while move == lastMove
            let modifier = modifiers.randomElement()!
            scramble.append(move + modifier)
            lastMove = move
        }
        return scramble.joined(separator: " ")
    }
    static func generate444Scramble() -> String {
        let moves = ["R", "L", "U", "D", "F", "B", "Rw", "Lw", "Uw", "Dw", "Fw", "Bw"]
        let modifiers = ["", "'", "2"]
        var scramble: [String] = []
        var lastMove = ""
        var beforeLastMove = ""
        for _ in 0..<40 {
            var move: String
            repeat {
                move = moves.randomElement()!
            } while move == lastMove || (move == beforeLastMove && areSameFace(move, lastMove))
            let modifier = modifiers.randomElement()!
            scramble.append(move + modifier)
            beforeLastMove = lastMove
            lastMove = move
        }
        return scramble.joined(separator: " ")
    }
    static func generatePyramScramble() -> String {
        let moves = ["U", "L", "R", "B"]
        let modifiers = ["", "'"]
        let tips = ["u", "l", "r", "b"]
        var scramble: [String] = []
        var lastMove = ""
        for _ in 0..<11 {
            var move: String
            repeat {
                move = moves.randomElement()!
            } while move == lastMove
            let modifier = modifiers.randomElement()!
            scramble.append(move + modifier)
            lastMove = move
        }
        for tip in tips.shuffled().prefix(Int.random(in: 2...4)) {
            scramble.append(tip + (modifiers.randomElement()!))
        }
        return scramble.joined(separator: " ")
    }
    static func generateSkewbScramble() -> String {
        let moves = ["R", "L", "U", "B"]
        let modifiers = ["", "'"]
        var scramble: [String] = []
        var lastMove = ""
        for _ in 0..<11 {
            var move: String
            repeat {
                move = moves.randomElement()!
            } while move == lastMove
            let modifier = modifiers.randomElement()!
            scramble.append(move + modifier)
            lastMove = move
        }
        return scramble.joined(separator: " ")
    }
    static func generateScramble(for eventId: String) -> String {
        switch eventId {
        case "222":
            return generate222Scramble()
        case "333", "333oh", "333bf":
            return generate333Scramble()
        case "444":
            return generate444Scramble()
        case "555":
            return generate555Scramble()
        case "666":
            return generate666Scramble()
        case "777":
            return generate777Scramble()
        case "pyram":
            return generatePyramScramble()
        case "skewb":
            return generateSkewbScramble()
        case "minx":
            return generateMinxScramble()
        case "sq1":
            return generateSq1Scramble()
        case "clock":
            return generateClockScramble()
        default:
            return generate333Scramble()
        }
    }
    private static func generate555Scramble() -> String {
        let moves = ["R", "L", "U", "D", "F", "B", "Rw", "Lw", "Uw", "Dw", "Fw", "Bw"]
        let modifiers = ["", "'", "2"]
        var scramble: [String] = []
        var lastMove = ""
        for _ in 0..<60 {
            var move: String
            repeat {
                move = moves.randomElement()!
            } while move == lastMove
            scramble.append(move + (modifiers.randomElement()!))
            lastMove = move
        }
        return scramble.joined(separator: " ")
    }
    private static func generate666Scramble() -> String {
        let moves = ["R", "L", "U", "D", "F", "B", "3Rw", "3Lw", "3Uw", "3Dw", "3Fw", "3Bw"]
        let modifiers = ["", "'", "2"]
        var scramble: [String] = []
        for _ in 0..<80 {
            let move = moves.randomElement()!
            scramble.append(move + (modifiers.randomElement()!))
        }
        return scramble.joined(separator: " ")
    }
    private static func generate777Scramble() -> String {
        let moves = ["R", "L", "U", "D", "F", "B", "3Rw", "3Lw", "3Uw", "3Dw", "3Fw", "3Bw"]
        let modifiers = ["", "'", "2"]
        var scramble: [String] = []
        for _ in 0..<100 {
            let move = moves.randomElement()!
            scramble.append(move + (modifiers.randomElement()!))
        }
        return scramble.joined(separator: " ")
    }
    private static func generateMinxScramble() -> String {
        let moves = ["R++", "R--", "D++", "D--", "U"]
        var scramble: [String] = []
        for _ in 0..<77 {
            scramble.append(moves.randomElement()!)
        }
        return scramble.joined(separator: " ")
    }
    private static func generateSq1Scramble() -> String {
        var scramble: [String] = []
        for _ in 0..<12 {
            let top = Int.random(in: -5...6)
            let bottom = Int.random(in: -5...6)
            scramble.append("(\(top),\(bottom))")
            if Bool.random() {
                scramble.append("/")
            }
        }
        return scramble.joined(separator: " ")
    }
    private static func generateClockScramble() -> String {
        let pins = ["UR", "DR", "DL", "UL", "U", "R", "D", "L", "ALL"]
        var scramble: [String] = []
        for pin in pins {
            let turns = Int.random(in: 0...6)
            let direction = Bool.random() ? "+" : "-"
            scramble.append("\(pin)\(turns)\(direction)")
        }
        return scramble.joined(separator: " ")
    }
    private static func areSameFace(_ move1: String, _ move2: String) -> Bool {
        let oppositePairs = [("R", "L"), ("U", "D"), ("F", "B")]
        for pair in oppositePairs {
            if (move1.hasPrefix(pair.0) && move2.hasPrefix(pair.1)) ||
               (move1.hasPrefix(pair.1) && move2.hasPrefix(pair.0)) {
                return true
            }
        }
        return false
    }
}
