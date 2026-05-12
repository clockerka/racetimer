import SwiftUI
struct TimerView: View {
    @EnvironmentObject var raceContext: RaceContext
    @State private var showMenu = false
    @State private var showScramble = false
    @State private var showPenalty = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerView(side: .player2)
                    .rotationEffect(.degrees(180))
                    .environmentObject(raceContext)
                    .onTapGesture {
                        if !raceContext.roundStarted {
                            showScramble = true
                        }
                    }
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 4)
                    if !raceContext.roundStarted {
                        HStack {
                            Button(LocalizedString.menu.localized) {
                                showMenu = true
                            }
                            .font(.system(size: 11))
                            .textCase(.uppercase)
                            .frame(width: 96)
                            .padding(.vertical, 8)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.primary.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .padding(.leading, 24)
                            Spacer()
                            Button(LocalizedString.penalty.localized) {
                                showPenalty = true
                            }
                            .font(.system(size: 11))
                            .textCase(.uppercase)
                            .frame(width: 96)
                            .padding(.vertical, 8)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.primary.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .padding(.trailing, 24)
                        }
                    }
                }
                .frame(height: 50)
                PlayerView(side: .player1)
                    .environmentObject(raceContext)
                    .onTapGesture {
                        if !raceContext.roundStarted {
                            showScramble = true
                        }
                    }
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $showMenu) {
            MenuView()
                .environmentObject(raceContext)
        }
        .sheet(isPresented: $showScramble) {
            ScrambleModalView()
                .environmentObject(raceContext)
        }
        .sheet(isPresented: $showPenalty) {
            PenaltyModalView()
                .environmentObject(raceContext)
        }
    }
}
#Preview {
    TimerView()
        .environmentObject(RaceContext())
}
