
import Foundation

struct Question: Identifiable, Codable {
    let id: Int
    let question: String
    let options: [String]
    let correctIndex: Int
    let timeLimit: Int
}
