import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                GenderPredictionView()
            }
            .tabItem {
                Label("Gender", systemImage: "person.text.rectangle")
            }

            NavigationStack {
                HighRatingPredictionView()
            }
            .tabItem {
                Label("High Rating", systemImage: "star.bubble")
            }

            NavigationStack {
                VisualizationView()
            }
            .tabItem {
                Label("Chart", systemImage: "chart.bar.xaxis")
            }
        }
        .tint(.pink)
    }
}
