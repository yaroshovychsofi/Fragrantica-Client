import SwiftUI

struct ActionPillButton: View {
    let title: String
    let systemImage: String
    var isProminent: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .font(.subheadline.weight(.semibold))
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .foregroundStyle(isProminent ? Color.white : Color.primary)
        .background(background)
        .clipShape(Capsule())
        .shadow(color: isProminent ? Color.pink.opacity(0.18) : Color.black.opacity(0.04), radius: 10, y: 6)
    }

    @ViewBuilder
    private var background: some View {
        if isProminent {
            LinearGradient(
                colors: [Color.pink, Color.purple],
                startPoint: .leading,
                endPoint: .trailing
            )
        } else {
            Color.white.opacity(0.9)
        }
    }
}
