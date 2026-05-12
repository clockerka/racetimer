import Foundation
enum LocalizedString {
    case ready
    case generating
    case handScramble
    case menu
    case penalty
    case timer
    case close
    case cancel
    case ok
    case stats
    case plusTwo
    case dnf
    case currentSession
    case player1
    case player2
    case eventP1
    case eventP2
    case rounds
    case actions
    case newSession
    case loadSession
    case viewSolves
    case settings
    case generateScrambles
    case language
    case playerNames
    case player1Name
    case player2Name
    case events
    case player1Event
    case player2Event
    case options
    case createSession
    case anonymous
    case sessions
    case delete
    case solves
    case best
    case worst
    case mean
    case ao5
    case ao12
    case puzzle222
    case puzzle333
    case puzzle444
    case puzzle555
    case puzzle666
    case puzzle777
    case puzzlePyram
    case puzzleSkewb
    case puzzleMinx
    case puzzleSq1
    case puzzleClock
    case puzzleOh
    case puzzleBld
    case changeEvent
    var localized: String {
        NSLocalizedString(self.key, comment: "")
    }
    private var key: String {
        switch self {
        case .ready: return "ready"
        case .generating: return "generating"
        case .handScramble: return "hand_scramble"
        case .menu: return "menu"
        case .penalty: return "penalty"
        case .timer: return "timer"
        case .close: return "close"
        case .cancel: return "cancel"
        case .ok: return "ok"
        case .stats: return "stats"
        case .plusTwo: return "plus_two"
        case .dnf: return "dnf"
        case .currentSession: return "current_session"
        case .player1: return "player_1"
        case .player2: return "player_2"
        case .eventP1: return "event_p1"
        case .eventP2: return "event_p2"
        case .rounds: return "rounds"
        case .actions: return "actions"
        case .newSession: return "new_session"
        case .loadSession: return "load_session"
        case .viewSolves: return "view_solves"
        case .settings: return "settings"
        case .generateScrambles: return "generate_scrambles"
        case .language: return "language"
        case .playerNames: return "player_names"
        case .player1Name: return "player_1_name"
        case .player2Name: return "player_2_name"
        case .events: return "events"
        case .player1Event: return "player_1_event"
        case .player2Event: return "player_2_event"
        case .options: return "options"
        case .createSession: return "create_session"
        case .anonymous: return "anonymous"
        case .sessions: return "sessions"
        case .delete: return "delete"
        case .solves: return "solves"
        case .best: return "best"
        case .worst: return "worst"
        case .mean: return "mean"
        case .ao5: return "ao5"
        case .ao12: return "ao12"
        case .puzzle222: return "puzzle_222"
        case .puzzle333: return "puzzle_333"
        case .puzzle444: return "puzzle_444"
        case .puzzle555: return "puzzle_555"
        case .puzzle666: return "puzzle_666"
        case .puzzle777: return "puzzle_777"
        case .puzzlePyram: return "puzzle_pyram"
        case .puzzleSkewb: return "puzzle_skewb"
        case .puzzleMinx: return "puzzle_minx"
        case .puzzleSq1: return "puzzle_sq1"
        case .puzzleClock: return "puzzle_clock"
        case .puzzleOh: return "puzzle_oh"
        case .puzzleBld: return "puzzle_bld"
        case .changeEvent: return "change_event"
        }
    }
}
