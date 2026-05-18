import SwiftUI

struct MeView: View {
    @State private var selectedTab = "Reviews"
    let tabs = ["Reviews", "Shelf", "Routine"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // Profile header
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                .frame(width: 72, height: 72)
                                .overlay(
                                    Text("D")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text("@divya")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text("medium neutral · combo skin")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            }
                            Spacer()
                            Button {
                            } label: {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            }
                        }

                        // Stats
                        HStack(spacing: 0) {
                            ProfileStat(value: "124", label: "reviews")
                            Divider().frame(height: 32)
                            ProfileStat(value: "42", label: "scans")
                            Divider().frame(height: 32)
                            ProfileStat(value: "18", label: "saved")
                            Divider().frame(height: 32)
                            ProfileStat(value: "891", label: "followers")
                        }
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(16)

                        // Skin profile
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Skin profile")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(["Combo skin", "Medium neutral", "Acne-prone", "No fragrance", "No coconut oil"], id: \.self) { tag in
                                        Text(tag)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color(red: 0.94, green: 0.91, blue: 0.87))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }

                        // Edit profile button
                        Button {} label: {
                            Text("Edit skin profile")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 0.84, green: 0.82, blue: 0.77), lineWidth: 1)
                                )
                        }
                    }
                    .padding(20)

                    // Tab switcher
                    HStack(spacing: 0) {
                        ForEach(tabs, id: \.self) { tab in
                            Button {
                                selectedTab = tab
                            } label: {
                                VStack(spacing: 8) {
                                    Text(tab)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(
                                            selectedTab == tab
                                            ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                            : Color(red: 0.60, green: 0.57, blue: 0.53)
                                        )
                                    Rectangle()
                                        .fill(
                                            selectedTab == tab
                                            ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                            : Color.clear
                                        )
                                        .frame(height: 1.5)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(Color(red: 0.97, green: 0.95, blue: 0.93))

                    Divider()

                    // Tab content
                    if selectedTab == "Reviews" {
                        ReviewsTabView()
                    } else if selectedTab == "Shelf" {
                        ShelfTabView()
                    } else {
                        MeRoutineTabView()
                    }
                }
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Me")
        }
    }
}

// MARK: - Profile Stat
struct ProfileStat: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
    }
}

// MARK: - Reviews Tab
struct ReviewsTabView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(["Barrier Cream", "Gentle Cleanser", "Invisible Mineral SPF"], id: \.self) { product in
                ShelfProductRow(
                    name: product,
                    detail: product == "Barrier Cream" ? "Expires Aug 2026 · in PM routine" : "Daily routine · no conflicts",
                    rating: product == "Gentle Cleanser" ? 4.8 : 4.5
                )
                Divider().padding(.horizontal, 20)
            }
        }
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(20)
        .padding(20)
    }
}

// MARK: - Shelf Tab
struct ShelfTabView: View {
    @State private var selectedShelfTab = "Owned"
    let shelfTabs = ["Owned", "Wishlist", "Scanned"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Sub tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(shelfTabs, id: \.self) { tab in
                        Button {
                            selectedShelfTab = tab
                        } label: {
                            Text(tab)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(
                                    selectedShelfTab == tab
                                    ? Color(red: 0.98, green: 0.97, blue: 0.95)
                                    : Color(red: 0.07, green: 0.07, blue: 0.07)
                                )
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(
                                    selectedShelfTab == tab
                                    ? Color(red: 0.07, green: 0.07, blue: 0.07)
                                    : Color(red: 0.98, green: 0.97, blue: 0.95)
                                )
                                .cornerRadius(20)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            VStack(spacing: 0) {
                ForEach(shelfProducts(for: selectedShelfTab), id: \.self) { product in
                    ShelfProductRow(
                        name: product,
                        detail: shelfDetail(for: product),
                        rating: 4.6
                    )
                    Divider().padding(.horizontal, 20)
                }
            }
            .background(Color(red: 0.98, green: 0.97, blue: 0.95))
            .cornerRadius(20)
            .padding(.horizontal, 20)

            Spacer(minLength: 32)
        }
    }

    func shelfProducts(for tab: String) -> [String] {
        switch tab {
        case "Owned": return ["Gentle Cleanser", "Retinol Cream", "Invisible Mineral SPF"]
        case "Wishlist": return ["Soft Veil Skin Tint", "Cloud Serum"]
        case "Scanned": return ["Gentle Exfoliant", "Barrier Cream", "Cloud Serum"]
        default: return []
        }
    }

    func shelfDetail(for product: String) -> String {
        switch product {
        case "Gentle Cleanser": return "Daily AM/PM · no conflicts"
        case "Retinol Cream": return "2 nights/week · active product"
        case "Invisible Mineral SPF": return "Daily AM reminder"
        case "Soft Veil Skin Tint": return "Shade 240 Neutral · saved"
        case "Gentle Exfoliant": return "Use carefully · scanned today"
        default: return "Saved to shelf"
        }
    }
}

// MARK: - Me Routine Tab
struct MeRoutineTabView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(["Gentle Cleanser", "Cloud Serum", "Invisible Mineral SPF", "Barrier Cream"], id: \.self) { product in
                ShelfProductRow(
                    name: product,
                    detail: product == "Barrier Cream" ? "PM only · recovery nights" : "Daily AM",
                    rating: 4.7
                )
                Divider().padding(.horizontal, 20)
            }
        }
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(20)
        .padding(20)
    }
}

// MARK: - Shelf Product Row
struct ShelfProductRow: View {
    let name: String
    let detail: String
    let rating: Double

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: "sparkles")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                )

            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            }

            Spacer()

            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}
