import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @Binding var path: NavigationPath
    @State private var totalTimeRemaining: Int = 1800 // 30 dakika = 1800 saniye

    var body: some View {
        if viewModel.isCompleted {
            ResultView(score: viewModel.score, total: viewModel.questions.count, path: $path)
        } else {
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 6)
                                .foregroundColor(.gray.opacity(0.2))
                                .frame(width: 50, height: 50)

                            Circle()
                                .trim(from: 0, to: CGFloat(Double(totalTimeRemaining) / 1800))
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .frame(width: 50, height: 50)
                                .animation(.easeInOut(duration: 1.0), value: totalTimeRemaining)

                            Text("\(formatTime(totalTimeRemaining))")
                                .font(.caption2)
                        }
                    }

                    Text("Soru \(viewModel.currentIndex + 1)/\(viewModel.questions.count)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Bu Soru İçin Kalan Süre: \(viewModel.timeRemaining) sn")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(viewModel.questions[viewModel.currentIndex].question)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(viewModel.questions[viewModel.currentIndex].options.indices, id: \.self) { index in
                        Button(action: {
                            viewModel.answer(index)
                        }) {
                            HStack {
                                Image(systemName: "circle")
                                    .font(.headline)
                                Text(viewModel.questions[viewModel.currentIndex].options[index])
                                    .font(.body)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        .foregroundColor(.primary)
                    }

                    Spacer()
                }
                .frame(maxWidth: 600)
                .padding()
                .animation(.easeInOut(duration: 0.5), value: viewModel.currentIndex)
                .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if totalTimeRemaining > 0 {
                        totalTimeRemaining -= 1
                    } else {
                        viewModel.isCompleted = true
                        timer.invalidate()
                    }
                }
            }
        }
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}
