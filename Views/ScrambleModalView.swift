import SwiftUI
import SVGView
struct ScrambleModalView: View {
    @EnvironmentObject var raceContext: RaceContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text(LocalizedString.player2.localized)
                        .font(.headline)
                        .padding(.top, 20)
                    if raceContext.scramblesGenerating {
                        Spacer()
                        ProgressView(LocalizedString.generating.localized)
                            .font(.title2)
                        Spacer()
                    } else {
                        ScrollView {
                            Text(raceContext.currentRound.scramble.player2)
                                .font(.system(size: 24, weight: .medium))
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                            if let svgStr = raceContext.currentRound.scrambleSVG?.player2 {
                                SVGView(string: svgStr)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 180)
                                    .padding()
                            }
                        }
                    }
                }
                .frame(height: geometry.size.height / 2)
                .background(Color(UIColor.systemBackground))
                .rotationEffect(.degrees(180))
                Divider()
                    .frame(height: 2)
                    .background(Color.gray)
                VStack(spacing: 0) {
                    Text(LocalizedString.player1.localized)
                        .font(.headline)
                        .padding(.top, 20)
                    if raceContext.scramblesGenerating {
                        Spacer()
                        ProgressView(LocalizedString.generating.localized)
                            .font(.title2)
                        Spacer()
                    } else {
                        ScrollView {
                            Text(raceContext.currentRound.scramble.player1)
                                .font(.system(size: 24, weight: .medium))
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                            if let svgStr = raceContext.currentRound.scrambleSVG?.player1 {
                                SVGView(string: svgStr)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 180)
                                    .padding()
                            }
                        }
                    }
                    Button(LocalizedString.close.localized) {
                        dismiss()
                    }
                    .padding(.bottom, 20)
                }
                .frame(height: geometry.size.height / 2)
                .background(Color(UIColor.systemBackground))
            }
        }
        .ignoresSafeArea()
    }
}
#Preview {
    ScrambleModalView()
        .environmentObject(RaceContext())
}
