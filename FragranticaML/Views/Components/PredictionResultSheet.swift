import SwiftUI

struct PredictionDetailRow: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let value: String
}

struct PredictionResultSheet: View {
    let title: String
    let subtitle: String
    let probabilityText: String?
    let details: [PredictionDetailRow]
    let buttonTitle: String
    let onClose: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                headerIcon

                VStack(spacing: 8) {
                    Text(title)
                        .font(.title2.weight(.bold))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)

                    Text(subtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }

                if let probabilityText {
                    infoBadge(probabilityText)
                }

                if !details.isEmpty {
                    detailsCard
                }

                Button(action: onClose) {
                    Text(buttonTitle)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color.pink, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .shadow(color: .pink.opacity(0.18), radius: 10, y: 6)
                }
                .buttonStyle(.plain)
                .padding(.top, 4)
            }
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
        .presentationDetents(details.isEmpty ? [.medium] : [.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private var headerIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.pink, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 76, height: 76)
                .shadow(color: .pink.opacity(0.20), radius: 14, y: 8)

            Image(systemName: "sparkles.rectangle.stack.fill")
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(.white)
        }
    }

    private func infoBadge(_ text: String) -> some View {
        Text(text)
            .font(.headline.weight(.semibold))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var detailsCard: some View {
        VStack(spacing: 0) {
            ForEach(Array(details.enumerated()), id: \.element.id) { index, row in
                HStack(alignment: .top, spacing: 12) {
                    Text(row.title)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(row.value)
                        .font(.subheadline.weight(.semibold))
                        .multilineTextAlignment(.trailing)
                        .frame(alignment: .trailing)
                }
                .padding(.vertical, 12)

                if index < details.count - 1 {
                    Divider()
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
