import Foundation

struct PredictionRequest: Codable {
    let brand: String
    let country: String
    let ratingCount: Int
    let year: Int
    let mainaccord1: String
    let mainaccord2: String
    let mainaccord3: String
    let mainaccord4: String
    let mainaccord5: String

    enum CodingKeys: String, CodingKey {
        case brand
        case country
        case ratingCount = "rating_count"
        case year
        case mainaccord1
        case mainaccord2
        case mainaccord3
        case mainaccord4
        case mainaccord5
    }
}

struct GenderPredictionResponse: Codable {
    let prediction: String
    let probability: Double?
    let classProbabilities: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case prediction
        case probability
        case classProbabilities = "class_probabilities"
    }
}

struct HighRatingPredictionResponse: Codable {
    let prediction: Int
    let label: String
    let probability: Double?
}

struct FeaturesResponse: Codable {
    let featureColumns: [String]

    enum CodingKeys: String, CodingKey {
        case featureColumns = "feature_columns"
    }
}

struct HealthResponse: Codable {
    let status: String
    let modelsLoaded: Bool

    enum CodingKeys: String, CodingKey {
        case status
        case modelsLoaded = "models_loaded"
    }
}
