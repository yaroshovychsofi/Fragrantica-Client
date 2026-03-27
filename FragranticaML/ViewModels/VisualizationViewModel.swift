import Foundation
import Combine

final class VisualizationViewModel: ObservableObject {
    @Published var points: [VisualizationPoint] = []
    @Published var errorMessage: String?

    @MainActor
    func loadFromBundle() {
        guard let url = Bundle.main.url(forResource: "visualization_top_accords", withExtension: "json") else {
            errorMessage = "Could not find visualization_top_accords.json in the app bundle."
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([VisualizationPoint].self, from: data)
            points = decoded.sorted { $0.highRatingPercent > $1.highRatingPercent }
            errorMessage = nil
        } catch {
            errorMessage = "Could not load chart data: \(error.localizedDescription)"
        }
    }
}
