import Foundation
class ScrambleGenerator {
    static func getPuzzleIndex(for eventId: String) -> Int32 {
        switch eventId {
        case "222": return 0
        case "333": return 1
        case "444": return 2
        case "555": return 3
        case "666": return 4
        case "777": return 5
        case "sq1": return 6
        case "minx": return 7
        case "pyram": return 8
        case "clock": return 9
        case "skewb": return 10
        case "333oh": return 11
        case "333bf": return 12
        default: return 1
        }
    }
    static func generateScramble(for eventId: String) -> String {
        let puzzle = getPuzzleIndex(for: eventId)
        var isolate: OpaquePointer? = nil
        var thread: OpaquePointer? = nil
        graal_create_isolate(nil, &isolate, &thread)
        let s = String(cString: tnoodle_lib_scramble(thread, puzzle))
        graal_tear_down_isolate(thread)
        return s
    }
    static func drawScramble(for eventId: String, scramble: String) -> String? {
        let puzzle = getPuzzleIndex(for: eventId)
        var isolate: OpaquePointer? = nil
        var thread: OpaquePointer? = nil
        graal_create_isolate(nil, &isolate, &thread)
        var svgStr: String? = nil
        scramble.withCString { s in
            if let drawnSvg = tnoodle_lib_draw_scramble(thread, puzzle, s) {
                svgStr = String(cString: drawnSvg)
            }
        }
        graal_tear_down_isolate(thread)
        return svgStr
    }
}
