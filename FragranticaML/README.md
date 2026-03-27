# Fragrantica ML SwiftUI App

SwiftUI iOS client for Lab 6.

## Features
- Gender prediction screen
- High-rating prediction screen
- Separate visualization screen with a chart built in Swift using **Swift Charts**
- Works with the FastAPI backend created for the same lab

## Requirements
- Xcode 15+
- iOS 16+
- Running backend from `lab6_fastapi_backend`

## Important backend URL note
In `Config/AppConfig.swift`:
- `http://127.0.0.1:8000` works for the iOS Simulator if the backend runs on the same Mac
- for a physical iPhone, replace it with your Mac's LAN IP, for example `http://192.168.0.15:8000`

## Fastest way to run
### Option 1: create a new Xcode project manually
1. Open Xcode
2. Create a new **iOS App** project
3. Interface: **SwiftUI**
4. Language: **Swift**
5. Copy the contents of the `FragranticaMLSwiftUIApp` folder into your Xcode project
6. Make sure `visualization_top_accords.json` is added to the target resources
7. Run the backend
8. Build and run the app

### Option 2: generate an Xcode project with XcodeGen
1. Install XcodeGen if needed
2. In this folder run:
   ```bash
   xcodegen generate
   ```
3. Open the generated `.xcodeproj`
4. Run the app

## App structure
- `App/` – app entry point
- `Config/` – API base URL
- `Models/` – request/response models and chart model
- `Networking/` – API client
- `ViewModels/` – presentation logic
- `Views/` – SwiftUI screens and reusable components
- `Resources/` – bundled JSON for visualization

## Visualization used in the app
The chart screen shows the **share of high-rated perfumes among the top 10 most frequent `mainaccord1` values**.
The chart is rendered directly on iOS with **Swift Charts**.


## UI update
- Added Shuffle sample and Clear actions for both prediction forms.
- Added a bundled `prediction_samples.json` resource with random valid records from the real dataset.
- Refreshed the form design with card-based sections, gradients, and Swift Charts styling.


## Backend-powered shuffle

The shuffle button now requests `GET /sample/random` from the FastAPI backend.
This avoids bundle-resource issues on iOS and guarantees that the sample payload matches the backend schema.
