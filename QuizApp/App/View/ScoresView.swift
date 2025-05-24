import SwiftUI

struct ScoresView: View {
    @State private var scores: [ScoreEntry] = []
    
    var body: some View {
        VStack {
            Text("Geçmiş Skorlar")
                .font(.largeTitle)
                .bold()
                .padding()
            
            if scores.isEmpty {
                Text("Henüz kayıtlı bir skor yok.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(scores.reversed()) { score in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Skor: \(score.score)/\(score.total)")
                                    .font(.headline)
                                Text(score.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteScore)
                }
            }
            
            Spacer()
        }
        .onAppear {
            scores = ScoreStorage().fetchScores()
        }
    }
    
    func deleteScore(at offsets: IndexSet) {
        scores.remove(atOffsets: offsets)
        let updated = Array(scores.reversed())
        if let data = try? JSONEncoder().encode(updated) {
            UserDefaults.standard.set(data, forKey: "quiz_scores")
        }
    }
}
