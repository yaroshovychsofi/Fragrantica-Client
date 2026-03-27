import SwiftUI

struct HighRatingPredictionView: View {
    @StateObject private var viewModel = HighRatingPredictionViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.orange.opacity(0.08), Color.pink.opacity(0.10), Color(.systemGroupedBackground)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    ScreenHeaderCard(
                        eyebrow: "Model two",
                        title: "High-rating prediction",
                        subtitle: "Estimate whether a perfume belongs to the high-rating class using the same features as the first model.",
                        systemImage: "sparkles.rectangle.stack.fill"
                    )

                    PredictionFormFields(
                        input: $viewModel.input,
                        onShuffle: { Task { await viewModel.shuffleInput() } },
                        onClear: { viewModel.clearInput() }
                    )

                    PrimaryGradientButton(
                        title: "Predict high rating",
                        systemImage: "star.fill",
                        isLoading: viewModel.isLoading
                    ) {
                        Task { await viewModel.predict() }
                    }

                    if let errorMessage = viewModel.errorMessage {
                        ResultCard(title: "Error") {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                        }
                    }
                }
                .padding()
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("High-rating model")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.isResultSheetPresented) {
            PredictionResultSheet(
                title: viewModel.predictionTitle,
                subtitle: viewModel.predictionSubtitle,
                probabilityText: viewModel.probabilityText,
                details: viewModel.detailRows,
                buttonTitle: "Close"
            ) {
                viewModel.dismissResultSheet()
            }
        }
    }
}
