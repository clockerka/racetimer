import SwiftUI
struct MenuView: View {
    @EnvironmentObject var raceContext: RaceContext
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    @State private var showNewSession = false
    @State private var showSessions = false
    @State private var showSolves = false
    @State private var showChangeEventP1 = false
    @State private var showChangeEventP2 = false
    var body: some View {
        NavigationView {
            List {
                Section(LocalizedString.currentSession.localized) {
                    HStack {
                        Text(LocalizedString.player1.localized)
                        Spacer()
                        Text(raceContext.session.playerNames.player1 ?? LocalizedString.anonymous.localized)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(LocalizedString.player2.localized)
                        Spacer()
                        Text(raceContext.session.playerNames.player2 ?? LocalizedString.anonymous.localized)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(LocalizedString.eventP1.localized)
                        Spacer()
                        Button(action: {
                            showChangeEventP1 = true
                        }) {
                            Text(raceContext.session.selectedEvents.player1.name)
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack {
                        Text(LocalizedString.eventP2.localized)
                        Spacer()
                        Button(action: {
                            showChangeEventP2 = true
                        }) {
                            Text(raceContext.session.selectedEvents.player2.name)
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack {
                        Text(LocalizedString.rounds.localized)
                        Spacer()
                        Text("\(raceContext.session.completedRounds.count)")
                            .foregroundColor(.secondary)
                    }
                }
                Section(LocalizedString.actions.localized) {
                    Button(action: {
                        showNewSession = true
                    }) {
                        Label(LocalizedString.newSession.localized, systemImage: "plus.circle")
                    }
                    Button(action: {
                        showSessions = true
                    }) {
                        Label(LocalizedString.loadSession.localized, systemImage: "folder")
                    }
                    Button(action: {
                        showSolves = true
                    }) {
                        Label(LocalizedString.viewSolves.localized, systemImage: "list.bullet")
                    }
                }
                Section(LocalizedString.settings.localized) {
                    Toggle(LocalizedString.generateScrambles.localized, isOn: Binding(
                        get: { raceContext.session.generateScrambles },
                        set: { newValue in
                            raceContext.session.generateScrambles = newValue
                        }
                    ))
                    Picker(LocalizedString.language.localized, selection: $languageManager.currentLanguage) {
                        ForEach(languageManager.availableLanguages, id: \.0) { code, name in
                            Text(name).tag(code)
                        }
                    }
                }
            }
            .navigationTitle(LocalizedString.menu.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(LocalizedString.close.localized) {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showNewSession) {
            NewSessionView()
                .environmentObject(raceContext)
        }
        .sheet(isPresented: $showSessions) {
            SessionsListView()
                .environmentObject(raceContext)
        }
        .sheet(isPresented: $showSolves) {
            SolvesView()
                .environmentObject(raceContext)
        }
        .sheet(isPresented: $showChangeEventP1) {
            EventPickerView(side: .player1)
                .environmentObject(raceContext)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showChangeEventP2) {
            EventPickerView(side: .player2)
                .environmentObject(raceContext)
                .presentationDetents([.medium])
        }
    }
}
#Preview {
    MenuView()
        .environmentObject(RaceContext())
}
