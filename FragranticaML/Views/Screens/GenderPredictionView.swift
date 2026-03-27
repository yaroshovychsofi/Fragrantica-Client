import SwiftUI

struct GenderPredictionView: View {
    @StateObject private var viewModel = GenderPredictionViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.pink.opacity(0.12), Color.purple.opacity(0.08), Color(.systemGroupedBackground)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    ScreenHeaderCard(
                        eyebrow: "Model one",
                        title: "Gender prediction",
                        subtitle: "Use perfume metadata and main accords to estimate the target gender category of a fragrance.",
                        systemImage: "person.text.rectangle.fill"
                    )

                    PredictionFormFields(
                        input: $viewModel.input,
                        onShuffle: { Task { await viewModel.shuffleInput() } },
                        onClear: { viewModel.clearInput() }
                    )

                    PrimaryGradientButton(
                        title: "Predict gender",
                        systemImage: "wand.and.stars",
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
        .navigationTitle("Gender model")
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
