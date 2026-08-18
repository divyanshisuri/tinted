import SwiftUI

struct HomeView: View {
    let products = Product.todayPicks
    let productOfTheWeek = Product.productOfTheWeek
    let tip = WeeklyTip.thisWeek
    @StateObject private var weatherManager = SkinWeatherManager()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Product of the week")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                            .textCase(.uppercase)
                            .tracking(0.5)

                        NavigationLink(destination: ProductDetailView(product: productOfTheWeek)) {
                            HStack(spacing: 14) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Image(systemName: "sparkles")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    )
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(productOfTheWeek.name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    Text("\(productOfTheWeek.brand) · matched with \(productOfTheWeek.fitScore)% of users with your skin type")
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
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Skin weather index")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            Spacer()
                            Text(weatherManager.index.locationName)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        }
                        .padding(.horizontal, 20)

                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .stroke(Color(red: 0.90, green: 0.87, blue: 0.82), lineWidth: 6)
                                Circle()
                                    .trim(from: 0, to: CGFloat(weatherManager.index.score) / 100)
                                    .stroke(
                                        Color(red: 0.07, green: 0.07, blue: 0.07),
                                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                                    )
                                    .rotationEffect(.degrees(-90))
                                Text("\(weatherManager.index.score)")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            }
                            .frame(width: 48, height: 48)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("UV \(weatherManager.index.uvIndex) · Humidity \(weatherManager.index.humidityPercent)%")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text(weatherManager.index.advisory)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
                        }
                        .padding(16)
                        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }

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
                                    NavigationLink(destination: ProductDetailView(product: product)) {
                                        ProductCard(product: product)
                                            .frame(width: 220)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

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

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Weekly skin tip")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 20)

                        HStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Image(systemName: "lightbulb.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                )
                            VStack(alignment: .leading, spacing: 4) {
                                Text(tip.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                Text(tip.body)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
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
            .onAppear {
                weatherManager.requestIndex()
            }
        }
    }
}

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
