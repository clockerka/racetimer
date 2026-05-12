import SwiftUI
struct NewSessionView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    @State private var player1Name: String = ""
    @State private var player2Name: String = ""
    @State private var player1Event: Event = Event.getEvent(byId: "333")
    @State private var player2Event: Event = Event.getEvent(byId: "333")
    @State private var generateScrambles: Bool = true
    var body: some View {
        NavigationView {
            Form {
                Section(LocalizedString.playerNames.localized) {
                    TextField(LocalizedString.player1Name.localized, text: $player1Name)
                    TextField(LocalizedString.player2Name.localized, text: $player2Name)
                }
                Section(LocalizedString.events.localized) {
                    Picker(LocalizedString.player1Event.localized, selection: $player1Event) {
                        ForEach(Event.events) { event in
                            Text(event.name).tag(event)
                        }
                    }
                    Picker(LocalizedString.player2Event.localized, selection: $player2Event) {
                        ForEach(Event.events) { event in
                            Text(event.name).tag(event)
                        }
                    }
                }
                Section(LocalizedString.options.localized) {
                    Toggle(LocalizedString.generateScrambles.localized, isOn: $generateScrambles)
                }
                Section {
                    Button(LocalizedString.createSession.localized) {
                        let p1Name = player1Name.isEmpty ? nil : player1Name
                        let p2Name = player2Name.isEmpty ? nil : player2Name
                        raceContext.startNewSession(
                            playerNames: SideMap(player1: p1Name, player2: p2Name),
                            selectedEvents: SideMap(player1: player1Event, player2: player2Event),
                            generateScrambles: generateScrambles
                        )
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(LocalizedString.newSession.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(LocalizedString.cancel.localized) {
                        dismiss()
                    }
                }
            }
        }
    }
}
#Preview {
    NewSessionView()
        .environmentObject(RaceContext())
}
