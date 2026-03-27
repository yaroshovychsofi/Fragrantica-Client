import Foundation

struct VisualizationPoint: Codable, Identifiable {
    let accord: String
    let totalCount: Int
    let highRatingPercent: Double

    var id: String { accord }
}
