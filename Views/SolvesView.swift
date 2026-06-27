import SwiftUI
struct SolvesView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    var showCloseButton: Bool = true
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
<<<<<<< HEAD
                    VStack {
=======
                    VStack(spacing: 0) {
>>>>>>> e424f6e (fixed scrambles)
                        Text(LocalizedString.solves.localized)
                            .font(.headline)
                            .padding(.vertical, 10)
                            .padding(.top, max(geometry.safeAreaInsets.top, 0))
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.secondarySystemBackground))
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                ForEach(Array(raceContext.session.completedRounds.enumerated()), id: \.offset) { index, round in
                                    if let solve = round.solves.player2 {
                                        HStack {
                                            Text("\(index + 1).")
                                                .font(.system(.body, design: .monospaced))
                                                .foregroundColor(.secondary)
                                                .frame(width: 40, alignment: .trailing)
                                            Text(solve.displayTime)
                                                .font(.system(.body, design: .monospaced))
                                                .fontWeight(.semibold)
                                                .frame(width: 80, alignment: .leading)
                                            Text(round.scramble.player2)
                                                .font(.system(size: 12))
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
<<<<<<< HEAD
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
=======
                    .frame(height: geometry.size.height / 2)
>>>>>>> e424f6e (fixed scrambles)
                    .background(Color(UIColor.systemBackground))
                    .rotationEffect(.degrees(180))
                    Divider()
                        .frame(height: 2)
                        .background(Color.gray)
<<<<<<< HEAD
                    VStack {
=======
                    VStack(spacing: 0) {
>>>>>>> e424f6e (fixed scrambles)
                        Text(LocalizedString.solves.localized)
                            .font(.headline)
                            .padding(.vertical, 10)
                            .padding(.top, max(geometry.safeAreaInsets.top, 0))
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.secondarySystemBackground))
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                ForEach(Array(raceContext.session.completedRounds.enumerated()), id: \.offset) { index, round in
                                    if let solve = round.solves.player1 {
                                        HStack {
                                            Text("\(index + 1).")
                                                .font(.system(.body, design: .monospaced))
                                                .foregroundColor(.secondary)
                                                .frame(width: 40, alignment: .trailing)
                                            Text(solve.displayTime)
                                                .font(.system(.body, design: .monospaced))
                                                .fontWeight(.semibold)
                                                .frame(width: 80, alignment: .leading)
                                            Text(round.scramble.player1)
                                                .font(.system(size: 12))
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
<<<<<<< HEAD
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
=======
                    .frame(height: geometry.size.height / 2)
>>>>>>> e424f6e (fixed scrambles)
                    .background(Color(UIColor.systemBackground))
                }
                if showCloseButton {
                    VStack {
                        HStack {
                            Spacer()
                            Button(LocalizedString.close.localized) {
                                dismiss()
                            }
                            .padding(.trailing, 16)
                            .padding(.top, max(geometry.safeAreaInsets.top, 8) + 8)
                        }
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}
#Preview {
    SolvesView()
        .environmentObject(RaceContext())
}
