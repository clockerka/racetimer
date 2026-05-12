import SwiftUI
struct PenaltyModalView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("\(LocalizedString.player2.localized) \(LocalizedString.penalty.localized)")
                    .font(.headline)
                    .padding(.top, 20)
                Spacer()
                HStack(spacing: 20) {
                    Button(LocalizedString.ok.localized) {
                        raceContext.setPenalty(side: .player2, penalty: nil)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .frame(maxWidth: .infinity)
                    Button(LocalizedString.plusTwo.localized) {
                        raceContext.setPenalty(side: .player2, penalty: .plusTwo)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .tint(.orange)
                    .frame(maxWidth: .infinity)
                    Button(LocalizedString.dnf.localized) {
                        raceContext.setPenalty(side: .player2, penalty: .dnf)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 40)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .rotationEffect(.degrees(180))
            Divider()
                .frame(height: 2)
                .background(Color.gray)
            VStack {
                Text("\(LocalizedString.player1.localized) \(LocalizedString.penalty.localized)")
                    .font(.headline)
                    .padding(.top, 20)
                Spacer()
                HStack(spacing: 20) {
                    Button(LocalizedString.ok.localized) {
                        raceContext.setPenalty(side: .player1, penalty: nil)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .frame(maxWidth: .infinity)
                    Button(LocalizedString.plusTwo.localized) {
                        raceContext.setPenalty(side: .player1, penalty: .plusTwo)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .tint(.orange)
                    .frame(maxWidth: .infinity)
                    Button(LocalizedString.dnf.localized) {
                        raceContext.setPenalty(side: .player1, penalty: .dnf)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 40)
                Spacer()
                Button(LocalizedString.cancel.localized) {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .ignoresSafeArea()
    }
}
#Preview {
    PenaltyModalView()
        .environmentObject(RaceContext())
}
