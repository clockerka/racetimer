import SwiftUI
struct EventPickerView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    let side: Side
    var body: some View {
        NavigationView {
            List {
                ForEach(Event.events) { event in
                    Button(action: {
                        raceContext.changeEvent(side: side, newEvent: event)
                        dismiss()
                    }) {
                        HStack {
                            Text(event.name)
                                .foregroundColor(.primary)
                            Spacer()
                            if raceContext.session.selectedEvents[side].id == event.id {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle(LocalizedString.changeEvent.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(LocalizedString.close.localized) {
                        dismiss()
                    }
                }
            }
        }
    }
}
#Preview {
    EventPickerView(side: .player1)
        .environmentObject(RaceContext())
}
