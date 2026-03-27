import Charts
import SwiftUI

struct VisualizationView: View {
    @StateObject private var viewModel = VisualizationViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.07), Color.pink.opacity(0.08), Color(.systemGroupedBackground)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ScreenHeaderCard(
                        eyebrow: "Visualization",
                        title: "Top accords vs high rating",
                        subtitle: "Swift Charts displays the share of high-rated perfumes across the top 10 main accords.",
                        systemImage: "chart.bar.fill"
                    )

                    if let errorMessage = viewModel.errorMessage {
                        ResultCard(title: "Error") {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                        }
                    } else {
                        ResultCard(title: "Bar chart") {
                            Chart(viewModel.points) { item in
                                BarMark(
                                    x: .value("Accord", item.accord),
                                    y: .value("High-rated, %", item.highRatingPercent)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.pink, Color.purple],
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                                .annotation(position: .top) {
                                    Text(item.highRatingPercent, format: .number.precision(.fractionLength(1)))
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(height: 320)
                            .chartYScale(domain: 0...100)
                            .chartXAxis {
                                AxisMarks(values: viewModel.points.map(\.accord)) { value in
                                    AxisValueLabel(centered: true) {
                                        if let label = value.as(String.self) {
                                            Text(label)
                                                .font(.caption2)
                                                .rotationEffect(.degrees(-35), anchor: .topTrailing)
                                                .fixedSize()
                                        }
                                    }
                                }
                            }
                        }

                        ResultCard(title: "Interpretation") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("This chart is rendered directly on iOS with Swift Charts.")
                                Text("The data is based on the real dataset and bundled as aggregated JSON for the app.")
                                if let best = viewModel.points.max(by: { $0.highRatingPercent < $1.highRatingPercent }) {
                                    Text("Highest share in the sample: \(best.accord.capitalized) with \(best.highRatingPercent, format: .number.precision(.fractionLength(1)))% high-rated perfumes.")
                                }
                            }
                        }
                    }
                }
                .padding()
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Visualization")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel.points.isEmpty {
                viewModel.loadFromBundle()
            }
        }
    }
}
