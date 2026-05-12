import SwiftUI
struct TimerArea: View {
    @ObservedObject var timerMachine: TimerMachine
    let timerText: String
    let timerColor: Color
    let timerTextColor: Color
    @State private var isTouching = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(timerColor)
            Text(timerText)
                .font(.system(size: 64, weight: .regular, design: .monospaced))
                .foregroundColor(timerTextColor)
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isTouching {
                        isTouching = true
                        timerMachine.handsDown()
                    }
                }
                .onEnded { _ in
                    isTouching = false
                    timerMachine.handsUp()
                }
        )
    }
}
