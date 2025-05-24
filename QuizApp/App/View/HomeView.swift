import SwiftUI

enum Route: Hashable {
    case quiz
    case scores
}

struct HomeView: View {
    @StateObject private var viewModel = QuizViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 40) {
                        Text("Quiz Uygulamsı")
                            .font(.largeTitle)
                            .bold()
                        Text("Bu sınav 25 adet Tarih sorusundan oluşmaktadır")
                            .font(.title)
                            .multilineTextAlignment(.center)
                        Button("Başla") {
                            viewModel.loadQuestions()
                            path.append(Route.quiz)
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        
                        Button("Geçmiş Skorlar") {
                            path.append(Route.scores)
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(12)
                    }
                    .frame(maxWidth: 500)
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .quiz:
                    QuizView(viewModel: viewModel, path: $path)
                case .scores:
                    ScoresView()
                }
            }
        }
    }
}
