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
                            Text("\(session.completedRounds.count) \(LocalizedString.rounds.localized)")
                                .font(.caption)
                                .foregroundColor(.secondary)
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
        let p1 = session.playerNames.player1 ?? "P1"
        let p2 = session.playerNames.player2 ?? "P2"
        return "\(p1) vs \(p2)"
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
