import Foundation

struct PredictionFormInput: Codable {
    var brand: String
    var country: String
    var ratingCount: String
    var year: String
    var mainaccord1: String
    var mainaccord2: String
    var mainaccord3: String
    var mainaccord4: String
    var mainaccord5: String

    static let empty = PredictionFormInput(
        brand: "",
        country: "",
        ratingCount: "",
        year: "",
        mainaccord1: "",
        mainaccord2: "",
        mainaccord3: "",
        mainaccord4: "",
        mainaccord5: ""
    )

    static let preview = PredictionFormInput(
        brand: "avon",
        country: "usa",
        ratingCount: "119",
        year: "2011",
        mainaccord1: "floral",
        mainaccord2: "woody",
        mainaccord3: "fruity",
        mainaccord4: "powdery",
        mainaccord5: "citrus"
    )

    init(
        brand: String,
        country: String,
        ratingCount: String,
        year: String,
        mainaccord1: String,
        mainaccord2: String,
        mainaccord3: String,
        mainaccord4: String,
        mainaccord5: String
    ) {
        self.brand = brand
        self.country = country
        self.ratingCount = ratingCount
        self.year = year
        self.mainaccord1 = mainaccord1
        self.mainaccord2 = mainaccord2
        self.mainaccord3 = mainaccord3
        self.mainaccord4 = mainaccord4
        self.mainaccord5 = mainaccord5
    }

    init(request: PredictionRequest) {
        self.brand = request.brand
        self.country = request.country
        self.ratingCount = String(request.ratingCount)
        self.year = String(request.year)
        self.mainaccord1 = request.mainaccord1
        self.mainaccord2 = request.mainaccord2
        self.mainaccord3 = request.mainaccord3
        self.mainaccord4 = request.mainaccord4
        self.mainaccord5 = request.mainaccord5
    }

    func toRequest() throws -> PredictionRequest {
        guard let ratingCount = Int(ratingCount), ratingCount >= 0 else {
            throw APIError.validationError("Rating count must be a non-negative integer.")
        }

        guard let year = Int(year), (1800...2100).contains(year) else {
            throw APIError.validationError("Year must be between 1800 and 2100.")
        }

        let trimmedBrand = brand.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedCountry = country.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAccords = [mainaccord1, mainaccord2, mainaccord3, mainaccord4, mainaccord5]
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        guard !trimmedBrand.isEmpty,
              !trimmedCountry.isEmpty,
              trimmedAccords.allSatisfy({ !$0.isEmpty }) else {
            throw APIError.validationError("Please fill in all fields before sending the request.")
        }

        return PredictionRequest(
            brand: trimmedBrand.lowercased(),
            country: trimmedCountry.lowercased(),
            ratingCount: ratingCount,
            year: year,
            mainaccord1: trimmedAccords[0].lowercased(),
            mainaccord2: trimmedAccords[1].lowercased(),
            mainaccord3: trimmedAccords[2].lowercased(),
            mainaccord4: trimmedAccords[3].lowercased(),
            mainaccord5: trimmedAccords[4].lowercased()
        )
    }
}
