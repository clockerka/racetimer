import Foundation
struct Event: Codable, Identifiable, Hashable {
    let id: String
    var name: String {
        switch id {
        case "222": return LocalizedString.puzzle222.localized
        case "333": return LocalizedString.puzzle333.localized
        case "444": return LocalizedString.puzzle444.localized
        case "555": return LocalizedString.puzzle555.localized
        case "666": return LocalizedString.puzzle666.localized
        case "777": return LocalizedString.puzzle777.localized
        case "333oh": return LocalizedString.puzzleOh.localized
        case "333bf": return LocalizedString.puzzleBld.localized
        case "skewb": return LocalizedString.puzzleSkewb.localized
        case "pyram": return LocalizedString.puzzlePyram.localized
        case "minx": return LocalizedString.puzzleMinx.localized
        case "sq1": return LocalizedString.puzzleSq1.localized
        case "clock": return LocalizedString.puzzleClock.localized
        default: return id
        }
    }
    let eventId: String
    static let events: [Event] = [
        Event(id: "222", eventId: "222"),
        Event(id: "333", eventId: "333"),
        Event(id: "444", eventId: "444"),
        Event(id: "555", eventId: "555"),
        Event(id: "666", eventId: "666"),
        Event(id: "777", eventId: "777"),
        Event(id: "333oh", eventId: "333oh"),
        Event(id: "333bf", eventId: "333bf"),
        Event(id: "skewb", eventId: "skewb"),
        Event(id: "pyram", eventId: "pyram"),
        Event(id: "minx", eventId: "minx"),
        Event(id: "sq1", eventId: "sq1"),
        Event(id: "clock", eventId: "clock")
    ]
    static func getEvent(byId id: String) -> Event {
        return events.first { $0.id == id } ?? events[1]
    }
}
