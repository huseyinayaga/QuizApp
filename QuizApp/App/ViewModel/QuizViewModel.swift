
import Foundation
import Combine
class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentIndex = 0
    @Published var score = 0
    @Published var isCompleted = false
    @Published var timeRemaining = 0

    private var timer: AnyCancellable?

    var currentQuestion: Question {
        questions[currentIndex]
    }

    init() {
        
    }

    func loadQuestions() {
            if let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let decoded = try? JSONDecoder().decode([Question].self, from: data) {
                self.questions = decoded
                currentIndex = 0
                score = 0
                isCompleted = false
                startTimer()
            }
        }
    func answer(_ index: Int) {
        if currentQuestion.correctIndex == index {
            score += 1
        }
        nextQuestion()
    }

    func nextQuestion() {
        timer?.cancel()

        if currentIndex + 1 < questions.count {
            currentIndex += 1
            startTimer()
        } else {
            isCompleted = true
        }
    }

    private func startTimer() {
        timeRemaining = currentQuestion.timeLimit

        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.nextQuestion()
                }
            }
    }
}
