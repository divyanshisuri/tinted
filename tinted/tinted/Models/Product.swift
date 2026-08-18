import SwiftUI

struct Product: Identifiable {
    let id: UUID
    let name: String
    let brand: String
    let price: Double
    let rating: Double
    let reviewCount: Int
    let category: String
    let fitScore: Int
    let isRoutineSafe: Bool
    let matchedShade: String?
    let tags: [String]
    let description: String

    init(
        id: UUID = UUID(),
        name: String,
        brand: String,
        price: Double,
        rating: Double,
        reviewCount: Int,
        category: String,
        fitScore: Int,
        isRoutineSafe: Bool,
        matchedShade: String? = nil,
        tags: [String] = [],
        description: String = ""
    ) {
        self.id = id
        self.name = name
        self.brand = brand
        self.price = price
        self.rating = rating
        self.reviewCount = reviewCount
        self.category = category
        self.fitScore = fitScore
        self.isRoutineSafe = isRoutineSafe
        self.matchedShade = matchedShade
        self.tags = tags
        self.description = description
    }
}

// MARK: - Mock Data
extension Product {
    static let mockProducts: [Product] = [
        Product(
            name: "Soft Veil Skin Tint",
            brand: "Ilia",
            price: 32,
            rating: 4.8,
            reviewCount: 1284,
            category: "Makeup",
            fitScore: 89,
            isRoutineSafe: true,
            matchedShade: "240 Neutral",
            tags: ["Lightweight", "Buildable", "Dewy"],
            description: "A sheer, skin-perfecting tint that blurs and hydrates."
        ),
        Product(
            name: "Barrier Cream",
            brand: "Dr. Jart+",
            price: 48,
            rating: 4.6,
            reviewCount: 892,
            category: "Skincare",
            fitScore: 94,
            isRoutineSafe: true,
            tags: ["Fragrance-free", "Barrier repair", "Hydrating"],
            description: "Strengthens and restores the skin barrier overnight."
        ),
        Product(
            name: "Cloud Serum",
            brand: "Summer Fridays",
            price: 54,
            rating: 4.5,
            reviewCount: 673,
            category: "Skincare",
            fitScore: 82,
            isRoutineSafe: true,
            tags: ["No duplicate actives", "Brightening"],
            description: "A whipped serum that plumps and smooths skin."
        ),
        Product(
            name: "Invisible Mineral SPF",
            brand: "Supergoop",
            price: 38,
            rating: 4.7,
            reviewCount: 2341,
            category: "Skincare",
            fitScore: 96,
            isRoutineSafe: true,
            tags: ["No white cast", "Daily", "Mineral"],
            description: "A weightless mineral sunscreen with no white cast."
        ),
        Product(
            name: "Retinol Cream",
            brand: "Paula's Choice",
            price: 62,
            rating: 4.4,
            reviewCount: 445,
            category: "Skincare",
            fitScore: 78,
            isRoutineSafe: false,
            tags: ["Active", "2x weekly", "Anti-aging"],
            description: "A gentle retinol formula for smoother, firmer skin."
        ),
        Product(
            name: "Gentle Cleanser",
            brand: "CeraVe",
            price: 16,
            rating: 4.8,
            reviewCount: 5621,
            category: "Skincare",
            fitScore: 98,
            isRoutineSafe: true,
            tags: ["Daily", "Fragrance-free", "Gentle"],
            description: "A non-stripping cleanser for all skin types."
        )
    ]

    static let todayPicks: [Product] = Array(mockProducts.prefix(3))

    // Candidates a "product of the week" pick rotates through, so it alternates
    // rather than showing the same match every time.
    static let weeklyMatchCandidates: [Product] = [mockProducts[3], mockProducts[1], mockProducts[0]]

    static var productOfTheWeek: Product {
        let week = Calendar.current.component(.weekOfYear, from: Date())
        return weeklyMatchCandidates[week % weeklyMatchCandidates.count]
    }
}
