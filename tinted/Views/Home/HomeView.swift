import SwiftUI

struct HomeView: View {
    let products = Product.todayPicks

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {

                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Today for you")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        Text("Medium neutral · combo skin")
                            .font(.system(size: 13))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // Today's picks
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Matched for you")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            Spacer()
                            Button("View all") {}
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                        .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(products) { product in
                                    ProductCard(product: product)
                                        .frame(width: 220)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // Routine today
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's routine")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 20)

                        VStack(spacing: 0) {
                            RoutineRow(time: "AM", step: "Gentle Cleanser", done: true)
                            Divider().padding(.horizontal, 20)
                            RoutineRow(time: "AM", step: "Cloud Serum", done: true)
                            Divider().padding(.horizontal, 20)
                            RoutineRow(time: "AM", step: "Invisible Mineral SPF", done: false)
                            Divider().padding(.horizontal, 20)
                            RoutineRow(time: "PM", step: "Barrier Cream only", done: false, isWarning: true)
                        }
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }

                    // Live now banner
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Live now")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 20)

                        HStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Text("LIVE")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Foundation launch test")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text("Medium neutral skin · 1.2k watching")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 32)
                }
            }
            .background(Color(red: 0.97, green: 0.95, blue: 0.93))
            .navigationTitle("Tinted")
        }
    }
}

// MARK: - Routine Row
struct RoutineRow: View {
    let time: String
    let step: String
    let done: Bool
    var isWarning: Bool = false

    var body: some View {
        HStack(spacing: 14) {
            Text(time)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                .frame(width: 28)

            Text(step)
                .font(.system(size: 14))
                .foregroundColor(
                    isWarning
                    ? Color(red: 0.75, green: 0.45, blue: 0.20)
                    : Color(red: 0.07, green: 0.07, blue: 0.07)
                )
                .strikethrough(done)

            Spacer()

            if done {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
            } else if isWarning {
                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.75, green: 0.45, blue: 0.20))
            } else {
                Image(systemName: "circle")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.84, green: 0.82, blue: 0.77))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}
