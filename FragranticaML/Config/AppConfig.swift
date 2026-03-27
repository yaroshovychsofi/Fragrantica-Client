import Foundation

enum AppConfig {
    /// For iOS Simulator with backend running locally on the same Mac, `http://127.0.0.1:8000` works.
    /// For a real iPhone, replace it with your Mac's LAN IP, for example `http://192.168.0.15:8000`.
    static let baseURL = URL(string: "http://127.0.0.1:8000")!
}
