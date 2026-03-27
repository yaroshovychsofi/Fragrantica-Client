import Foundation
import Combine

final class GenderPredictionViewModel: ObservableObject {
    @Published var input = PredictionFormInput.preview
    @Published var result: GenderPredictionResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var isResultSheetPresented = false
    @Published var predictionTitle = ""
    @Published var predictionSubtitle = ""
    @Published var probabilityText: String?
    @Published var detailRows: [PredictionDetailRow] = []

    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    @MainActor
    func predict() async {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let request = try input.toRequest()
            let response = try await apiClient.predictGender(request)

            result = response
            configureSheet(from: response)
            isResultSheetPresented = true
        } catch {
            result = nil
            isResultSheetPresented = false
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func shuffleInput() async {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let sample = try await apiClient.fetchRandomSample()
            input = PredictionFormInput(request: sample)
            result = nil
            isResultSheetPresented = false
        } catch {
            result = nil
            isResultSheetPresented = false
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func clearInput() {
        input = .empty
        result = nil
        errorMessage = nil
        isResultSheetPresented = false
        probabilityText = nil
        detailRows = []
    }

    @MainActor
    func dismissResultSheet() {
        isResultSheetPresented = false
    }

    private func configureSheet(from response: GenderPredictionResponse) {
        predictionTitle = "Gender prediction complete"
        predictionSubtitle = "Predicted class: \(response.prediction.capitalized)"

        if let probability = response.probability {
            probabilityText = "Top probability: \(String(format: "%.1f%%", probability * 100))"
        } else {
            probabilityText = nil
        }

        if let probabilities = response.classProbabilities {
            detailRows = probabilities
                .sorted { $0.value > $1.value }
                .map {
                    PredictionDetailRow(
                        title: $0.key.capitalized,
                        value: String(format: "%.1f%%", $0.value * 100)
                    )
                }
        } else {
            detailRows = []
        }
    }
}
