import SwiftUI
struct ScrambleModalView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(LocalizedString.player2.localized)
                    .font(.headline)
                    .padding(.top, 20)
                Spacer()
                if raceContext.scramblesGenerating {
                    ProgressView(LocalizedString.generating.localized)
                        .font(.title2)
                } else {
                    Text(raceContext.currentRound.scramble.player2)
                        .font(.system(size: 24, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .rotationEffect(.degrees(180))
            Divider()
                .frame(height: 2)
                .background(Color.gray)
            VStack {
                Text(LocalizedString.player1.localized)
                    .font(.headline)
                    .padding(.top, 20)
                Spacer()
                if raceContext.scramblesGenerating {
                    ProgressView(LocalizedString.generating.localized)
                        .font(.title2)
                } else {
                    Text(raceContext.currentRound.scramble.player1)
                        .font(.system(size: 24, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                Spacer()
                Button(LocalizedString.close.localized) {
                    dismiss()
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .ignoresSafeArea()
    }
}
#Preview {
    ScrambleModalView()
        .environmentObject(RaceContext())
}
