import SwiftUI

struct ProductCard: View {
    let product: Product
    @State private var isSaved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Product image placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.94, green: 0.91, blue: 0.87))
                .frame(height: 160)
                .overlay(
                    VStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 28))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                        Text(product.category)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                )

            VStack(alignment: .leading, spacing: 6) {

                // Name + save button
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(product.name)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        Text(product.brand)
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                    Spacer()
                    Button {
                        isSaved.toggle()
                    } label: {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                    }
                }

                // Fit score + routine safe
                HStack(spacing: 8) {
                    Text("Fit \(product.fitScore)%")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color(red: 0.94, green: 0.91, blue: 0.87))
                        .cornerRadius(20)

                    if product.isRoutineSafe {
                        Text("routine-safe")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color(red: 0.94, green: 0.91, blue: 0.87))
                            .cornerRadius(20)
                    }
                }

                // Rating + price
                HStack {
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        Text(String(format: "%.1f", product.rating))
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        Text("· \(product.reviewCount) reviews")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.60, green: 0.57, blue: 0.53))
                    }
                    Spacer()
                    Text("$\(Int(product.price))")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(14)
        .background(Color(red: 0.98, green: 0.97, blue: 0.95))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
