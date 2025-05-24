import SwiftUI
import Foundation

struct ResultView: View {
    let score: Int
    let total: Int
    @Binding var path: NavigationPath

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    Text("Sınav Bitti")
                        .font(.largeTitle)
                        .bold()

                    Text("Skorunuz: \(score)/\(total)")
                        .font(.title2)

                    Button(action: {
                        path.removeLast(path.count)
                    }) {
                        Text("Ana Ekrana Dön")
                            .padding()
                            .frame(width: 200)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: 500)
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            let entry = ScoreEntry(score: score, total: total)
            ScoreStorage().save(score: entry)
        }
    }
}
