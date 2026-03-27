import SwiftUI

struct PredictionFormFields: View {
    @Binding var input: PredictionFormInput
    let onShuffle: () -> Void
    let onClear: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    ActionPillButton(title: "Shuffle sample", systemImage: "shuffle", isProminent: true, action: onShuffle)
                    ActionPillButton(title: "Clear", systemImage: "xmark", action: onClear)
                }

                Text("Shuffle fills the form with a random perfume profile from the bundled dataset sample.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            sectionCard(title: "Basic information", subtitle: "Perfume metadata used by the models.", icon: "sparkles") {
                LabeledInputField(title: "Brand", placeholder: "e.g. avon", text: $input.brand, icon: "bag")
                LabeledInputField(title: "Country", placeholder: "e.g. usa", text: $input.country, icon: "globe.europe.africa")
                LabeledInputField(title: "Rating count", placeholder: "e.g. 119", text: $input.ratingCount, keyboard: .numberPad, icon: "number")
                LabeledInputField(title: "Year", placeholder: "e.g. 2011", text: $input.year, keyboard: .numberPad, icon: "calendar")
            }

            sectionCard(title: "Main accords", subtitle: "Top fragrance notes provided to the model.", icon: "leaf") {
                LabeledInputField(title: "Main accord 1", placeholder: "floral", text: $input.mainaccord1, icon: "1.circle")
                LabeledInputField(title: "Main accord 2", placeholder: "woody", text: $input.mainaccord2, icon: "2.circle")
                LabeledInputField(title: "Main accord 3", placeholder: "fruity", text: $input.mainaccord3, icon: "3.circle")
                LabeledInputField(title: "Main accord 4", placeholder: "powdery", text: $input.mainaccord4, icon: "4.circle")
                LabeledInputField(title: "Main accord 5", placeholder: "citrus", text: $input.mainaccord5, icon: "5.circle")
            }
        }
    }

    private func sectionCard<Content: View>(
        title: String,
        subtitle: String,
        icon: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(
                        LinearGradient(
                            colors: [Color.pink, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline.weight(.bold))
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            content()
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground).opacity(0.75))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(Color.white.opacity(0.8), lineWidth: 1)
        )
    }
}
