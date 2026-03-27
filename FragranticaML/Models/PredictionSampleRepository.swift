import Foundation

enum PredictionSampleRepository {
    static func randomSample() -> PredictionFormInput? {
        guard let url = Bundle.main.url(forResource: "prediction_samples", withExtension: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let samples = try JSONDecoder().decode([PredictionFormInput].self, from: data)
            return samples.randomElement()
        } catch {
            return nil
        }
    }
}
