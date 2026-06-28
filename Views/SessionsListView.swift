import SwiftUI
struct SessionsListView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    @State private var sessions: [Session] = []
    var body: some View {
        NavigationView {
            List {
                ForEach(sessions) { session in
                    Button(action: {
                        raceContext.selectSession(id: session.id)
                        dismiss()
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                if let name = session.name {
                                    Text(name)
                                        .font(.headline)
                                } else {
                                    Text(sessionDisplayName(session))
                                        .font(.headline)
                                }
                                Spacer()
                                if session.id == raceContext.session.id {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            Text("\(LocalizedString.rounds.localized) \(session.completedRounds.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            if session.name != nil || session.playerNames.player1 != nil || session.playerNames.player2 != nil {
                                let e1 = session.selectedEvents.player1.name
                                let e2 = session.selectedEvents.player2.name
                                Text("\(e1) vs \(e2)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Text(formatDate(session.createdDate))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            raceContext.deleteSession(id: session.id)
                            loadSessions()
                        } label: {
                            Label(LocalizedString.delete.localized, systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle(LocalizedString.sessions.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(LocalizedString.close.localized) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                loadSessions()
            }
        }
    }
    private func loadSessions() {
        sessions = raceContext.getAllSessions()
    }
    private func sessionDisplayName(_ session: Session) -> String {
        let p1 = session.playerNames.player1
        let p2 = session.playerNames.player2
        if let p1 = p1, let p2 = p2 {
            return "\(p1) vs \(p2)"
        } else if let p1 = p1 {
            let e2 = session.selectedEvents.player2.name
            return "\(p1) vs \(e2)"
        } else if let p2 = p2 {
            let e1 = session.selectedEvents.player1.name
            return "\(e1) vs \(p2)"
        } else {
            let e1 = session.selectedEvents.player1.name
            let e2 = session.selectedEvents.player2.name
            return "\(e1) vs \(e2)"
        }
    }
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
#Preview {
    SessionsListView()
        .environmentObject(RaceContext())
}
