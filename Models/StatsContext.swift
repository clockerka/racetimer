import Foundation
struct StatsContext: Codable {
    var solves: [Solve]
    var computedStats: ComputedStats
    init() {
        self.solves = []
        self.computedStats = ComputedStats()
    }
    mutating func addSolve(_ solve: Solve) {
        solves.append(solve)
        computeStats()
    }
    mutating func replaceLastSolve(_ solve: Solve) {
        if !solves.isEmpty {
            solves[solves.count - 1] = solve
            computeStats()
        }
    }
    private mutating func computeStats() {
        let validTimes = solves.compactMap { $0.effectiveTime }
        if validTimes.isEmpty {
            computedStats = ComputedStats()
            return
        }
        let best = validTimes.min()
        let worst = validTimes.max()
        let mean = validTimes.isEmpty ? nil : Double(validTimes.reduce(0, +)) / Double(validTimes.count)
        var ao5: Double? = nil
        if solves.count >= 5 {
            let last5 = Array(solves.suffix(5))
            ao5 = calculateAverage(last5, trim: 1)
        }
        var ao12: Double? = nil
        if solves.count >= 12 {
            let last12 = Array(solves.suffix(12))
            ao12 = calculateAverage(last12, trim: 1)
        }
        computedStats = ComputedStats(
            best: best,
            worst: worst,
            mean: mean.map { Int($0) },
            ao5: ao5.map { Int($0) },
            ao12: ao12.map { Int($0) }
        )
    }
    private func calculateAverage(_ solves: [Solve], trim: Int) -> Double? {
        let times = solves.compactMap { $0.effectiveTime }
        guard times.count == solves.count else { return nil }
        let sorted = times.sorted()
        let trimmed = Array(sorted.dropFirst(trim).dropLast(trim))
        guard !trimmed.isEmpty else { return nil }
        return Double(trimmed.reduce(0, +)) / Double(trimmed.count)
    }
}
struct ComputedStats: Codable {
    var best: Int?
    var worst: Int?
    var mean: Int?
    var ao5: Int?
    var ao12: Int?
    init(best: Int? = nil, worst: Int? = nil, mean: Int? = nil, ao5: Int? = nil, ao12: Int? = nil) {
        self.best = best
        self.worst = worst
        self.mean = mean
        self.ao5 = ao5
        self.ao12 = ao12
    }
}
