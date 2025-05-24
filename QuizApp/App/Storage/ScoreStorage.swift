
import Foundation

class ScoreStorage {
    private let key = "quiz_scores"

    func save(score: ScoreEntry) {
        var scores = fetchScores()
        scores.append(score)
        if let data = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func fetchScores() -> [ScoreEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let scores = try? JSONDecoder().decode([ScoreEntry].self, from: data) else {
            return []
        }
        return scores
    }
    
}
