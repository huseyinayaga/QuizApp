
import Foundation

struct ScoreEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let score: Int
    let total: Int

    init(score: Int, total: Int) {
        self.id = UUID()
        self.date = Date()
        self.score = score
        self.total = total
    }
}
